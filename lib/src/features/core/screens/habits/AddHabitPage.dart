import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/features/core/screens/habits/habit_formwidget.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';
import 'package:intl/intl.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final HabitController _habitController = Get.put(HabitController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  double width = 0.0;
  double height = 0.0;
  String _selectedFolder = "None";
  List<String> categoryList = [
    "Mind Growth",
    "Physical Growth",
    "Financial",
    "Deen"
  ];
  String _time = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "Daily";
  List<String> repeatList = [
    "Daily",
    "Weekly",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const SizedBox(height: 70),
          Container(
            // height: MediaQuery.of(context).size.height,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: darkColor,
            ),
            child: appBarAddHabit(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: darkColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: defaultSize, right: defaultSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HabitFormField(
                        title: "Title",
                        hint: "Your habit title",
                        controller: _titleController,
                      ),
                      const SizedBox(height: 15),
                      HabitFormField(
                          title: "Description",
                          hint: "Enter your description here",
                          controller: _descController),
                      const SizedBox(height: 15),
                      HabitFormField(
                        title: "Category",
                        hint: _selectedFolder,
                        widget: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: black),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: Theme.of(context).textTheme.titleSmall,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFolder = newValue!;
                            });
                          },
                          items: categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: greyColor),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      HabitFormField(
                        title: "Date",
                        hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
                        widget: IconButton(
                          onPressed: () {
                            _getDateFromUser();
                          },
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      HabitFormField(
                        title: "Time",
                        hint: _time,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      HabitFormField(
                        title: "Remind",
                        hint: "$_selectedRemind minutes early",
                        widget: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: black),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: Theme.of(context).textTheme.titleSmall,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue!);
                            });
                          },
                          items: remindList
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      HabitFormField(
                        title: "Repeat",
                        hint: _selectedRepeat,
                        widget: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: black),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: Theme.of(context).textTheme.titleSmall,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRepeat = newValue!;
                            });
                          },
                          items: repeatList
                              .map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value!,
                                style: const TextStyle(color: greyColor),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding appBarAddHabit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(defaultSize, 0, defaultSize, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: whiteColor, fontWeight: FontWeight.w100),
            ),
          ),
          Text(
            "New Habit",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: whiteColor, fontWeight: FontWeight.w800),
          ),
          GestureDetector(
            onTap: () => _validateData(),
            child: Text("Save",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: whiteColor, fontWeight: FontWeight.w100)),
          )
        ],
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
      _addHabitToDb();
      _habitController.getHabits();
      Get.offAll(() => Dashboard());
      _habitController.getHabits();
    } else if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: whiteColor,
        colorText: black,
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      print("it is null");
    }
  }

  _addHabitToDb() async {
    try {
      int value = await _habitController.addHabit(
        habit: Habit(
          title: _titleController.text,
          desc: _descController.text,
          category: _selectedFolder,
          date: convertDateTimeToString(_selectedDate),
          lastUpdated: todaysDateFormatted(),
          time: _time,
          remind: _selectedRemind,
          streaks: 0,
          repeat: _selectedRepeat,
          isCompleted: 0,
          isSkipped: 0,
        ),
      );
      print("My id is $value");
    } catch (e) {
      print("Error adding habit: $e");
    }
  }

  _getTimeFromUser({required bool isTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      print("Time Canceled");
    } else if (isTime == true) {
      setState(() {
        _time = pickedTime.format(context);
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        //
        hour: int.parse(_time.split(":")[0]),
        minute: int.parse(_time.split(":")[1].split(" ")[0]),
      ),
    );
  }
}

ThemeData myEmptyTheme = ThemeData();
