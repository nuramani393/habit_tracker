import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';

class HabitFormField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const HabitFormField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: whiteColor, fontWeight: FontWeight.w500),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 52,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: whiteColor, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Theme(
                  data: myEmptyTheme,
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: greyColor, fontSize: 14.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    style: TextStyle(color: black),
                    // style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ),
              widget == null ? Container() : Container(child: widget),
            ],
          ),
        ),
      ],
    );
  }
}

ThemeData myEmptyTheme = ThemeData();
