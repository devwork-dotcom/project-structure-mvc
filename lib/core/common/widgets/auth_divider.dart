import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

import '../../utils/constants/app_colors.dart';

/// An "or" divider for authentication screens.
///
/// Features:
/// - Two horizontal lines with "or" text in the center
/// - Styled for dark background
/// - Fade-in animation
class AuthDivider extends StatefulWidget {
  final String text;
  final int animationIndex;

  const AuthDivider({
    super.key,
    this.text = 'Or Log In with',
    this.animationIndex = 0,
  });

  @override
  State<AuthDivider> createState() => _AuthDividerState();
}

class _AuthDividerState extends State<AuthDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    // Delay based on animation index for staggered effect
    Future.delayed(Duration(milliseconds: 50 * widget.animationIndex), () {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        children: [
          Gap(50.w),
          Expanded(
            child: Container(
              height: 1.h,
              decoration: BoxDecoration(color: AppColors.containerBorder),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              text: widget.text,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Container(
              height: 1.h,
              decoration: BoxDecoration(color: AppColors.containerBorder),
            ),
          ),
          Gap(50.w),
        ],
      ),
    );
  }
}
