import 'package:flutter/material.dart';
import 'package:picknow/costants/mediaquery/mediaquery.dart';

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  const CustomText(
      {super.key,
      required this.text,
      this.textOverflow,
      required this.size,
      required this.color,
      this.textAlign,
      this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: weight,
          overflow: textOverflow,
          color: color,
          fontSize: mediaquerywidth(size, context)),
      softWrap: true,
    );
  }
}
