import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

import 'custom_text_field.dart';

class CustomTextBox extends StatelessWidget {
  final String? title;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  /// Forwarded CustomTextField params
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool poppins;
  final bool readOnly;

  /// Character counter
  final bool characterShow;
  final int? maxLength;
  final TextStyle? counterStyle;
  final int? maxLines;

  /// NEW - Optional Title Style
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;

  const CustomTextBox({
    super.key,
    this.title,
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.poppins = false,
    this.readOnly = false,
    this.characterShow = false,
    this.maxLength,
    this.counterStyle,
    this.maxLines = 1,

    /// Optional Title Style
    this.titleFontSize,
    this.titleFontWeight,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController =
        controller ?? TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        if (title != null && title!.isNotEmpty) ...[
          CustomText(
            text: title!,
            fontSize: titleFontSize ?? 14.sp,
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: titleColor ?? AppColors.textPrimary,
          ),
          SizedBox(height: 8.h),
        ],

        /// Text Field
        CustomTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          prefixIconPath: prefixIcon,
          suffixIcon: suffixIcon,
          poppins: poppins,
          readonly: readOnly,
          radius: 12,
          characterShow: characterShow,
          maxLength: maxLength,
          counterStyle: counterStyle,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
