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

class EditHabitPage extends StatefulWidget {
  final Habit? habit;
  const EditHabitPage({required this.habit, Key? key}) : super(key: key);

  @override
  State<EditHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<EditHabitPage> {
  final HabitController _habitController = Get.put(HabitController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  // DateTime _selectedDate = DateTime.now();

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
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _titleController.text = widget.habit?.title ?? '';
      _descController.text = widget.habit?.desc ?? '';
      _selectedFolder = widget.habit?.category ?? '';
      _time = widget.habit?.time ?? '';
      _selectedRemind = widget.habit?.remind ?? 5;
      _selectedRepeat = widget.habit?.repeat ?? '';
    }
    _habitController.getHabits();
  }

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
                        readOnly: true,
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
                        widget: IgnorePointer(
                          ignoring: true,
                          child: DropdownButton(
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
                      ),
                      TextButton(
                        child:
                            Text("Delete", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          _showDeleteConfirmationDialog(); // Close the dialog
                        },
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
      _editHabitToDb();
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

  _editHabitToDb() async {
    try {
      _habitController.updateHabit(
        widget.habit!.id!,
        _descController.text,
        _selectedFolder,
        _time,
        _selectedRemind,
      );
    } catch (e) {
      print("Error adding habit: $e");
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            "Confirm Deletion",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          content: Text(
            "Are you sure you want to delete this habit?",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w200),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: darkColor)),
              onPressed: () {
                Get.back(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: darkColor)),
              onPressed: () {
                _habitController.delete(widget.habit!);
                Get.offAll(Dashboard());
              },
            ),
          ],
        );
      },
    );
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
