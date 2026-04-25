import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  const CustomScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.isScrollable = true,
    this.padding,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: isScrollable
            ? SingleChildScrollView(
                controller: scrollController,
                padding: padding ?? EdgeInsets.all(16.h),
                child: child,
              )
            : Padding(padding: padding ?? EdgeInsets.all(16.h), child: child),
      ),
    );
  }
}

// class CustomScaffold extends StatelessWidget {
//   final Widget child;
//
//   /// 🔥 Optional AppBar
//   final PreferredSizeWidget? appBar;
//
//   /// Optional FAB
//   final Widget? floatingActionButton;
//
//   /// Control scroll
//   final bool isScrollable;
//
//   /// Control SafeArea
//   final bool useSafeArea;
//
//   /// Keyboard behaviour
//   final bool resizeToAvoidBottomInset;
//
//   const CustomScaffold({
//     super.key,
//     required this.child,
//     this.appBar,
//     this.floatingActionButton,
//     this.isScrollable = true,
//     this.useSafeArea = true,
//     this.resizeToAvoidBottomInset = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Widget bodyContent = isScrollable
//         ? SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: child,
//     )
//         : Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: child,
//     );
//
//     if (useSafeArea) {
//       bodyContent = SafeArea(child: bodyContent);
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       resizeToAvoidBottomInset: resizeToAvoidBottomInset,
//       appBar: appBar, // ✅ optional
//       body: bodyContent,
//       floatingActionButton: floatingActionButton,
//     );
//   }
// }
