import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_sizer.dart';
import '../../utils/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIconPath;
  final Function(String)? onFieldSubmit;
  final bool readonly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final int? maxLines;
  final InputBorder? focusedBorder;
  final Color? containerColor;
  final Color? fillColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final double? hintTextSize;
  final double? radius;
  final InputDecoration? decoration;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final String? Function(String?)? validator;

  /// NEW
  final bool poppins;

  /// 🔥 NEW
  final bool characterShow;
  final int? maxLength;
  final TextStyle? counterStyle;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.readonly = false,
    this.prefixIconPath,
    this.maxLines = 1,
    this.onFieldSubmit,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.radius,
    this.decoration,
    this.borderColor = AppColors.containerBorder,
    this.border = InputBorder.none,
    this.enabledBorder = InputBorder.none,
    this.focusedBorder = InputBorder.none,
    this.containerColor = AppColors.white,
    this.hintTextColor = AppColors.hintColor,
    this.hintTextSize = 14,
    this.suffixText,
    this.suffixTextStyle,
    this.validator,
    this.fillColor = AppColors.white,
    this.poppins = false,

    /// NEW
    this.characterShow = false,
    this.maxLength,
    this.counterStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int currentLength = 0;

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        currentLength = widget.controller?.text.length ?? 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    currentLength = widget.controller?.text.length ?? 0;
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onTextChanged);
      widget.controller?.addListener(_onTextChanged);
      if (mounted) {
        setState(() {
          currentLength = widget.controller?.text.length ?? 0;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = widget.poppins
        ? GoogleFonts.poppins(fontSize: 14.sp)
        : GoogleFonts.inter(fontSize: 14.sp);

    final TextStyle hintStyle =
        (widget.poppins
                ? GoogleFonts.poppins(fontSize: widget.hintTextSize)
                : GoogleFonts.inter(fontSize: widget.hintTextSize))
            .copyWith(color: widget.hintTextColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TextField
        Container(
          decoration: BoxDecoration(
            color: widget.containerColor,
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!)
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            maxLength: widget.maxLength,
            buildCounter:
                (
                  _, {
                  required int currentLength,
                  required bool isFocused,
                  int? maxLength,
                }) => null,
            readOnly: widget.readonly,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            onFieldSubmitted: widget.onFieldSubmit,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            style: textStyle,
            validator: widget.validator,
            decoration:
                widget.decoration ??
                InputDecoration(
                  prefixIcon: widget.prefixIconPath,
                  suffixIcon: widget.suffixIcon,
                  hintText: widget.hintText,
                  hintStyle: hintStyle,
                  border: widget.border,
                  enabledBorder: widget.enabledBorder,
                  focusedBorder: widget.focusedBorder,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.h,
                  ),
                ),
          ),
        ),

        /// 🔥 Character Counter
        if (widget.characterShow)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w, right: 20.w),
              child: Text(
                widget.maxLength != null
                    ? "$currentLength/${widget.maxLength} characters"
                    : "$currentLength",
                style:
                    widget.counterStyle ??
                    TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
              ),
            ),
          ),
      ],
    );
  }
}
