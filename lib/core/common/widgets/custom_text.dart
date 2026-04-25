import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? decorationThickness;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final FontStyle? fontStyle; // 👈 NEW
  final bool poppins;

  const CustomText({
    super.key,
    required this.text,
    this.textAlign,
    this.decorationThickness,
    this.maxLines,
    this.textOverflow,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.decoration,
    this.decorationColor,
    this.fontStyle, // 👈 NEW
    this.poppins = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = poppins
        ? GoogleFonts.poppins(
            decoration: decoration,
            decorationThickness: decorationThickness,
            decorationColor: decorationColor ?? AppColors.info,
            fontSize: fontSize,
            color: color ?? AppColors.textPrimary,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontStyle: fontStyle, // 👈 HERE
          )
        : GoogleFonts.inter(
            decoration: decoration,
            decorationThickness: decorationThickness,
            decorationColor: decorationColor ?? AppColors.info,
            fontSize: fontSize,
            color: color ?? AppColors.textPrimary,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontStyle: fontStyle, // 👈 HERE
          );

    return Text(
      text,
      textAlign: textAlign,
      style: textStyle,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
