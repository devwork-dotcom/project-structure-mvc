import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class ContainerShimmer extends StatelessWidget {
  final double height;
  final double width;
  final int count;
  final double borderRadius;
  final double spacing;

  const ContainerShimmer({
    super.key,
    this.height = 120,
    this.width = double.infinity,
    this.count = 1,
    this.borderRadius = 16,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == count - 1 ? 0 : spacing.h,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius.h),
              child: Container(
                height: height.h,
                width: width == double.infinity ? double.infinity : width.w,
                color: AppColors.containerBorder,
              ),
            ),
          );
        }),
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
            final dx = (t * 2 - 1) * width;

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
