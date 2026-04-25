import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';

import '../../utils/constants/app_sizer.dart';

class Loader extends StatelessWidget {
  final Color? color;
  final double? size;
  const Loader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SpinKitCircle(
        color: color ?? AppColors.primary,
        size: size ?? 28.sp,
      ),
    );
  }
}
