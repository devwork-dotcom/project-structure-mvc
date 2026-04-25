import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';

import '../../utils/constants/app_sizer.dart';

class GridviewShimmer extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double itemHeight;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double borderRadius;

  const GridviewShimmer({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.itemHeight = 340,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing.w,
          mainAxisSpacing: mainAxisSpacing.h,
          mainAxisExtent: itemHeight.h, // ✅ fixed height
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius.h),
            child: Container(color: AppColors.containerBorder),
          );
        },
      ),
    );
  }
}

class _Shimmer extends StatefulWidget {
  final Widget child;
  const _Shimmer({required this.child});

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final t = _controller.value;

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) {
            final width = rect.width;
            final dx = (t * 2 - 1) * width; // -width -> +width

            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.containerBorder,
                AppColors.containerSoft,
                AppColors.containerBorder,
              ],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlideGradientTransform(dx),
            ).createShader(rect);
          },
          child: widget.child,
        );
      },
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double dx;
  const _SlideGradientTransform(this.dx);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, 0, 0);
  }
}

// GridShimmer(
// crossAxisCount: 3,
// itemHeight: 280,
// itemCount: 9,
// )
