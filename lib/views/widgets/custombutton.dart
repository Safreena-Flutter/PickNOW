
import 'package:flutter/material.dart';
import '../../costants/mediaquery/mediaquery.dart';
import '../../costants/theme/appcolors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double elevation;
  final BorderSide? borderSide;
  final Widget? icon;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor, 
    this.textColor ,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.textStyle,
    this.elevation = 2.0,
    this.borderSide,
    this.icon,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? mediaquerywidth(0.85, context),
        height: height ?? mediaqueryheight(0.07, context),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor?? AppColors.orange,
            padding: padding,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderSide ?? BorderSide.none,
            ),
          ),
          child: icon == null
              ? Text(
                  text,
                  style: textStyle ?? TextStyle(color: textColor, fontSize: 16.0),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon!,
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: textStyle ??
                          TextStyle(color: textColor??AppColors.whiteColor, fontSize: 16.0),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}