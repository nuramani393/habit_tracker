import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(welcome),
          height: size.height * 0.2,
        ),
        const SizedBox(height: 10.0),
        Text(lTitle, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 5.0),
        Text(lSubTitle, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
