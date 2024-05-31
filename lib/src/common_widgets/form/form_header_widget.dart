import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween,
    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        const SizedBox(height: 15.0),
        Text(title,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 5.0),
        Text(subTitle,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
