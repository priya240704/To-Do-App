
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/add_task_bar.dart';
import 'package:todo_app/screens/login_page.dart';
import 'package:todo_app/screens/update_task.dart';
import '../service/theme_Service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final taskController = Get.put(TaskController());
    final auth = Get.put(AuthController());
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, //spacebetween means right side
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ), //intl depandency add krva ni to j date formate use thy
                      const Text(
                        "Today",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      // _showTasks(),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(AddTaskPage());
                    },
                    child: const Text("Add Task"))
              ],
            ),
          ),
          Expanded(
            // height: 500,
            child: StreamBuilder(
              stream: taskController.getTaskList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Task'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data![index].notes);
                      TaskModel task = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(UpdateTask(task: task));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Are You sure Delete Task!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        taskController.deleteTask(
                                            taskId: task.taskId);
                                        Get.back();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            //  width: SizeConfig.screenWidth * 0.78,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(task.color),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task.title,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              task.notes,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              task.remind,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          task.date,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          task.time,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
      drawer: drawerMenu(
          context: context,
          auth: auth.getUser(),
          loginOut: () {
            firebaseAuth.signOut();
            Get.to(LoginPage());
          }),
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,//theme.dart mathi
      actions: [
        GestureDetector(
          onTap: (){
            ThemeService().switchTheme();
          },
          child: Icon(/*Get.isDarkMode ?*/Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode? Colors.white:Colors.black,),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are You sure Delete Task!'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Yes'),
            ),
          ],
        );
      });
}

Widget drawerMenu(
    {required BuildContext context,
    required Stream<UserModel> auth,
    required Function loginOut}) {
  return Drawer(
    child: StreamBuilder<UserModel>(
        stream: auth,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Container();
          }
          return ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.lightBlueAccent),
                  accountName: Text(
                    snapshot.data!.name,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  accountEmail: Text(
                    snapshot.data!.email,
                    style: TextStyle(color: Colors.black),
                  ),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Icon(Icons.person) //Text
                      ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader


              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(fontSize: 17),
                ),
                onTap: () {
                  loginOut();
                },
              ),
            ],
          );
        }),
  );
}
