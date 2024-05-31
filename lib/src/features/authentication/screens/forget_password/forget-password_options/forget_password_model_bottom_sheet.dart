import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/screens/forget_password/forget-password_options/forget_password_btn_widget.dart';
import 'package:habit_tracker/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) => Container(
              padding: EdgeInsets.all(defaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fTitle,
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 5.0),
                  Text(fSubTitle,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: defaultSize),

                  //mail Widget
                  ForgetPasswordBtnWidget(
                    btnIcon: Icons.mail_outline_rounded,
                    title: "E-Mail",
                    subTitle: "Reset via Mail Verification",
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => ForgetPasswordMailScreen());
                    },
                  ),
                ],
              ),
            ));
  }
}

//nota kaki
//static means we can easily access using ForgetPasswordScreen.buildShowModalBottomSheet
// we dont have to create instance also