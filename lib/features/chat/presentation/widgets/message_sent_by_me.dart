import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/common/widgets/custom_text.dart';
import 'view_image_screen.dart';

class MessageSentByMe extends StatelessWidget {
  final String? message;
  final String? time;
  final String? image;

  const MessageSentByMe({super.key, this.message, this.time, this.image});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          if (image?.isNotEmpty == true) ...[
            GestureDetector(
              onTap: () => Get.to(() => ViewImageScreen(imageUrl: image)),
              child: Image.network(
                image!,
                fit: BoxFit.fill,
                height: 124.h,
                width: 124.w,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
          ],

          if (message?.isNotEmpty == true) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 8,
                    bottom: 8,
                  ),
                  constraints: BoxConstraints(maxWidth: 260.w),
                  decoration: const BoxDecoration(
                    color: AppColors.containerSoft,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                  child: CustomText(
                    text: message!,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                CustomText(
                  text: _formatTime(time),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  String _formatTime(String? rawTime) {
    if (rawTime == null) return '';
    try {
      final dateTime = DateTime.parse(rawTime).toLocal();
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      return rawTime;
    }
  }
}
