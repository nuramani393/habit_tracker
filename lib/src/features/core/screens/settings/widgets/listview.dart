import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  String title;
  IconData? leadingIcon, trailingIcon;
  VoidCallback? onTrailingIconTap;

  ListTileWidget({
    super.key,
    required this.title,
    // this.iconColor,
    this.leadingIcon,
    // this.listTileColor,
    this.trailingIcon,
    this.onTrailingIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 25, 25, 0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        tileColor: whiteColor,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        leading: leadingIcon != null
            ? Icon(
                leadingIcon,
                color: black,
                size: 30,
              )
            : null,
        trailing: GestureDetector(
          onTap: onTrailingIconTap, // Call the callback function
          child: Icon(
            trailingIcon,
            color: black,
            size: 30,
          ),
        ),
      ),
    );
  }
}
