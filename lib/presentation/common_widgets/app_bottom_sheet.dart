import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomSheet {
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    required String title,
    double? maxHeight,
    double? minHeight,
    VoidCallback? onCallback,
    Widget? backWidget,
    bool isShowTitle = true,
    bool isDismissible = true,
    bool isShowKeyboard = false,
    bool enableDrag = true,
    bool isCloseButton = false,
  }) async {
    final result = await showModalBottomSheet(
        elevation: 0,
        isScrollControlled: true,
        enableDrag: enableDrag,
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? 1.sh - 250.h,
          minHeight: minHeight ?? 0.0,
        ),
        backgroundColor: Colors.white,
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.w),
          topLeft: Radius.circular(12.w),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              if (isShowTitle) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 17.sp,
                          color: AppColors.grey700,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      if (isCloseButton) ...[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/close.svg',
                            color: AppColors.grey700,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
              child,
              SizedBox(height: isShowKeyboard ? MediaQuery.of(context).viewInsets.bottom : 0),
            ],
          );
        });

    return result;
  }
}
