import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              oTitle,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 80.0,
                color: black,
              ),
              // style: Theme.of(context).textTheme.displayLarge
            ),
            Text(
              oSubTitle.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 40.0),
            Text("$oMessage aaa@g.com",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(
              height: 20.0,
            ),
            OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 16, color: black),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("OTP is => $pin");
                }),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Next"),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
