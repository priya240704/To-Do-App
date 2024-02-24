import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/service/theme.dart';
import '../service/theme_Service.dart';

class UpdateTask extends StatefulWidget {
  TaskModel task;
  UpdateTask({super.key, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  // String ddd() => widget.task.title;
  // var aaa = widget.task.title;

  final taskController = Get.put(TaskController());
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController remindcontroller=TextEditingController();
  final _selectedDate = DateFormat.yMMMMd().format(DateTime.now());
  var time = DateFormat.jm().format(DateTime.now());
  int _selectedColor = 0;

  int _selectedRemind = 5;

  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.task.title;
    noteController.text = widget.task.notes;
    remindcontroller.text=widget.task.remind;
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: "Enter title here",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        margin: EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: noteController,
                                decoration: InputDecoration(
                                    hintText: "Enter Your note",
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 50,
                            margin: EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: noteController,
                                    decoration: InputDecoration(
                                        hintText: "Enter Your note",
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Remind",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 50,
                                margin: EdgeInsets.only(top: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: remindcontroller,
                                        decoration: InputDecoration(
                                            hintText: "$_selectedRemind minutes early",
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey)),
                                            icon: DropdownButton(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.grey,
                                              ),
                                              iconSize: 32,
                                              elevation: 4,
                                              //style: subTitleStyle,
                                              underline: Container(
                                                height: 0,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedRemind =
                                                      int.parse(newValue!);
                                                });
                                              },
                                              items: remindList.map<
                                                  DropdownMenuItem<String>>(
                                                      (int value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value.toString(),
                                                      child: Text(value.toString()),
                                                    );
                                                  }).toList(),
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Color",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Wrap(
                                      children: List<Widget>.generate(
                                          3, //meand 3 cicrcle avatar avya
                                          (int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColor = index;
                                        });
                                      }, //circle par click thy

                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: index == 0
                                              ? primaryClr
                                              : index == 1
                                                  ? pinkClr
                                                  : yellowClr,
                                          child: _selectedColor == index
                                              ? Icon(Icons.done,
                                                  color: Colors.white, size: 16)
                                              : Container(),
                                        ),
                                      ),
                                    );
                                  }))
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    int color = _getBGClr(_selectedColor);
                                    print(_selectedDate);
                                    print(time);
                                    print(color);
                                    validateData(
                                        widget.task.taskId,
                                        titleController.text,
                                        noteController.text,
                                        remindcontroller.text,
                                        _selectedDate,
                                        time,
                                        color);
                                  },
                                  child: Text("Update Task"))
                            ],
                          ),
                        ],
                      ),
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ]),
        )));
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return 0xFF4e5ae8;
      // bluishClr;
      case 1:
        return 0xFFff4667;
      // pinkClr;
      case 2:
        return 0xFFFFB746;
      // yellowClr;
      default:
        return 0xFF4e5ae8;
      // bluishClr;
    }
  }


  validateData(String taskId, String title, String remind, String notes, String date,
      String time, int color) {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty && remindcontroller.text.isNotEmpty) {
      //add to database
      //addTaskToDb();
      taskController.updateTask(
        taskId: taskId,
        title: title,
        notes: notes,
        remind: remind,
        date: date,
        time: time,
        color: color,
      );
      print(titleController.text);
      print(noteController.text);
      print(remindcontroller.text);
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty || remindcontroller.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.pinkAccent,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.pinkAccent,
          ));
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
           ThemeService().switchTheme();
          Get.back();
        },
        child: Icon(
          /*Get.isDarkMode?*/ Icons.arrow_back,
          // color: Get.isDarkMode? Colors.white:Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
