import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDatePicker extends StatefulWidget {
  final String? value;
  final String icon;
  final Function? onTap;
  final String? label;
  final TextStyle? styleLabel;
  final String? hintText;
  final bool isRequired;
  final String? validator;

  const AppDatePicker({
    Key? key,
    required this.icon,
    this.value,
    this.onTap,
    this.label = "",
    this.styleLabel,
    this.hintText,
    this.isRequired = false,
    this.validator,
  }) : super(key: key);

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label?.isNotEmpty == true) ...[
          Row(
            children: [
              AppTextWidget(
                text: widget.label!,
                textStyle: widget.styleLabel ??
                    AppStyle.bold14black.copyWith(
                      color: AppColors.black3B3B3B,
                    ),
              ),
              if (widget.isRequired) ...[
                SizedBox(width: 4.w),
                Text(
                  "*",
                  style: AppStyle.medium16black.copyWith(
                    color: AppColors.danger,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
        ],
        GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap?.call();
            }
          },
          child: Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: (widget.validator?.isNotEmpty ?? false) ? AppColors.danger500 : AppColors.grey200, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.value == null) ...[
                  AppTextWidget(
                    text: widget.hintText ?? '',
                    textStyle: AppStyle.medium14black.copyWith(
                      color: AppColors.grey300,
                    ),
                  ),
                ],
                if (widget.value != null) ...[
                  SizedBox(
                    child: Text(
                      widget.value ?? '',
                      style: AppStyle.medium14black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                SvgPicture.asset(
                  widget.icon,
                  width: 24.w,
                  height: 24.w,
                )
              ],
            ),
          ),
        ),
        if (widget.validator?.isNotEmpty ?? false) ...{
          Container(
            color: AppColors.white,
            margin: EdgeInsets.only(top: 2.h),
            child: Text(
              tr(widget.validator!),
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.danger,
              ),
            ),
          )
        }
      ],
    );
  }
}
