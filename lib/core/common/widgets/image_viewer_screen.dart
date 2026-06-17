import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:saver_gallery/saver_gallery.dart';
import '../../utils/constants/app_sizer.dart';
import 'package:get/get.dart';

class ImageViewerScreen extends StatefulWidget {
  final String? imageUrl;
  final List<String>? imageUrls;

  const ImageViewerScreen({
    super.key,
    this.imageUrl,
    this.imageUrls,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late List<String> _images;
  int _currentIndex = 0;
  late final PageController _pageController;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty) {
      _images = widget.imageUrls!;
      final idx = widget.imageUrl != null ? _images.indexOf(widget.imageUrl!) : -1;
      _currentIndex = idx != -1 ? idx : 0;
    } else {
      _images = [widget.imageUrl ?? ""];
      _currentIndex = 0;
    }
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Check and request permissions based on platform and OS version
  Future<bool> checkAndRequestPermissions() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return false;
    }

    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      if (sdkInt >= 33) {
        return await Permission.photos.request().isGranted;
      } else {
        return await Permission.storage.request().isGranted;
      }
    } else {
      return await Permission.photosAddOnly.request().isGranted;
    }
  }

  /// Download and save image to gallery
  Future<void> saveImageToGallery() async {
    if (_images.isEmpty || _images[_currentIndex].isEmpty) return;

    setState(() {
      _isDownloading = true;
    });

    try {
      final hasPermission = await checkAndRequestPermissions();

      if (!hasPermission) {
        AppSnackBar.error(
          "Storage permission is required to save the image.",
          title: "Permission Denied",
        );
        return;
      }

      final response = await Dio().get(
        _images[_currentIndex],
        options: Options(responseType: ResponseType.bytes),
      );

      final Uint8List imageBytes = Uint8List.fromList(response.data);

      final result = await SaverGallery.saveImage(
        imageBytes,
        quality: 100,
        fileName: "my_apps${DateTime.now().millisecondsSinceEpoch}.png",
        androidRelativePath: "Pictures/bargains",
        skipIfExists: false,
      );

      /// Success check
      if (result.isSuccess == true) {
        AppSnackBar.success(
          "Image saved to gallery successfully.",
          title: "Success",
        );
      } else {
        AppSnackBar.error(
          "Failed to save image.",
          title: "Failed",
        );
      }
    } catch (e) {
      AppSnackBar.error(
        "An error occurred while downloading the image.",
        title: "Error",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Image View with Zoom and Swipe Support
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: CachedNetworkImage(
                      imageUrl: _images[index],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),

          // Top Overlay: Back and Download Buttons
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withAlpha(75),
                  ),
                ),

                // Download Button with Loading State
                _isDownloading
                    ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
                    : IconButton(
                  onPressed: saveImageToGallery,
                  icon: Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withAlpha(75),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Thumbnails Carousel Overlay
          if (_images.length > 1)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 16.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 60.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: _images.length,
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final isSelected = index == _currentIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            width: 2.w,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
