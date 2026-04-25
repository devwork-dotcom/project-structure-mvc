import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String imagePath;

  // Optional params
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeholder;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const CachedImage({
    super.key,
    required this.imagePath,
    this.height = 40,
    this.width = 40,
    this.borderRadius = 8,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholder,
    this.shimmerBaseColor = AppColors.containerBorder,
    this.shimmerHighlightColor = AppColors.containerSoft,
  });

  bool get isCircle => borderRadius >= 100;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,

      height: height,
      width: width,

      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),

      placeholder: (context, url) =>
          placeholder ??
          Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: isCircle
                    ? null
                    : BorderRadius.circular(borderRadius),
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                color: AppColors.white,
              ),
            ),
          ),

      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: isCircle
                  ? null
                  : BorderRadius.circular(borderRadius),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              color: AppColors.containerBorder,
            ),
            child: const Icon(Icons.image_not_supported, size: 20),
          ),
    );
  }
}
