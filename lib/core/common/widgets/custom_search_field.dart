import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;
  final double borderRadius;
  final Color borderColor;

  /// NEW
  final bool poppins;
  final double fontSize;
  final Color textColor;
  final Color hintColor;

  const CustomSearchField({
    super.key,
    this.onChanged,
    this.hintText = "Search",
    this.borderRadius = 33,
    this.borderColor = AppColors.textSecondary,
    this.poppins = false, // default Inter
    this.fontSize = 14,
    this.textColor = AppColors.textPrimary,
    this.hintColor = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = poppins
        ? GoogleFonts.poppins(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w400,
          )
        : GoogleFonts.inter(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w400,
          );

    final hintStyle = textStyle.copyWith(color: hintColor);

    return TextField(
      onChanged: onChanged,
      style: textStyle, // typed text
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle, //hint text
        prefixIcon: Icon(Icons.search, color: hintColor),
        filled: true,
        fillColor: AppColors.white.withAlpha(0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }
}

///Use Cases
// CustomSearchField(
// hintText: 'Search',
// poppins: true,
// fontSize: 16,
// textColor: AppColors.black,
// hintColor: AppColors.hintColor,
// );
