import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool withAsterisk;
  final List<String> items;
  final String selectedValue;
  final Color? borderColor;
  final ValueChanged<String> onChanged;
  final double height;
  final double borderRadius;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  /// NEW
  final bool poppins;
  final Color textColor;
  final Color hintColor;

  const CustomDropdownField({
    super.key,
    this.label,
    required this.hintText,
    this.withAsterisk = false,
    required this.items,
    required this.selectedValue,
    this.borderColor = AppColors.white,
    required this.onChanged,
    this.height = 48,
    this.borderRadius = 6,
    this.fontSize = 14,
    this.padding,
    this.poppins = false,
    this.textColor = AppColors.textPrimary,
    this.hintColor = AppColors.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle = poppins
        ? GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          )
        : GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: effectiveTextStyle,
              children: [
                if (withAsterisk)
                  TextSpan(
                    text: ' *',
                    style: effectiveTextStyle.copyWith(color: AppColors.error),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          height: height,
          padding: padding ?? const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? AppColors.textSecondary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Selected value / hint
              Expanded(
                child: Text(
                  selectedValue.isEmpty ? hintText : selectedValue,
                  style: effectiveTextStyle.copyWith(
                    color: selectedValue.isEmpty
                        ? hintColor
                        : effectiveTextStyle.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// Dropdown
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: onChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: AppColors.white,
                itemBuilder: (context) {
                  return items.map((item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item, style: effectiveTextStyle),
                    );
                  }).toList();
                },
                offset: const Offset(0, 40),
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// CustomDropdownField(
// label: 'Gender',
// hintText: 'Select Gender',
// items: ['Male', 'Female', 'Other'],
// selectedValue: selectedGender,
// onChanged: (value) => setState(() => selectedGender = value),
// withAsterisk: true,
// poppins: true,
// );
