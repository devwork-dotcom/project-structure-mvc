import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class CustomGradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? decorationThickness;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final FontStyle? fontStyle;
  final bool poppins;

  const CustomGradientText({
    super.key,
    required this.text,
    this.gradient = AppColors.mindsetAlignGradient,
    this.textAlign,
    this.decorationThickness,
    this.maxLines,
    this.textOverflow,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.decorationColor,
    this.fontStyle,
    this.poppins = false,
  });

  @override
  Widget build(BuildContext context) {
    // এখানে কালারটি অবশ্যই Colors.white হতে হবে, নাহলে গ্রেডিয়েন্ট মাস্ক ঠিকমতো বসবে না
    final TextStyle textStyle = poppins
        ? GoogleFonts.poppins(
      decoration: decoration,
      decorationThickness: decorationThickness,
      decorationColor: decorationColor ?? AppColors.info,
      fontSize: fontSize,
      color: Colors.white, // 👈 ফিক্সড সাদা কালার
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    )
        : GoogleFonts.roboto(
      decoration: decoration,
      decorationThickness: decorationThickness,
      decorationColor: decorationColor ?? AppColors.info,
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,// এটি টেক্সটের ভেতরের অংশটুকুকে গ্রেডিয়েন্ট দিয়ে পূর্ণ করবে
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: textStyle,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}