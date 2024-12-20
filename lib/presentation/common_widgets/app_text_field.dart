import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? initialValue;
  final String? hintText;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isRequired;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? validator;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? label;
  final TextStyle? styleLabel;

  const AppTextField(
      {Key? key,
      required this.controller,
      this.initialValue,
      this.hintText,
      this.maxLength,
      this.maxLine = 1,
      this.keyboardType,
      this.isRequired = false,
      this.suffixIcon,
      this.onChanged,
      this.validator,
      this.enable = true,
      this.inputFormatters,
      this.obscureText = false,
      this.label = "",
      this.styleLabel})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label?.isNotEmpty == true) ...[
          Row(
            children: [
              Text(
                tr(widget.label!),
                style: widget.styleLabel ??
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
          SizedBox(height: 8.w),
        ],
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          maxLength: widget.maxLength,
          obscuringCharacter: "●",
          obscureText: widget.obscureText,
          maxLines: widget.maxLine,
          enabled: widget.enable,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            filled: widget.enable ? null : true,
            fillColor: widget.enable ? null : AppColors.grey50,
            counter: const Offstage(),
            contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.w),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.grey500), borderRadius: BorderRadius.circular(8.w)),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.danger500 : AppColors.grey200),
              borderRadius: BorderRadius.circular(8.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.danger500 : AppColors.grey200),
              borderRadius: BorderRadius.circular(8.w),
            ),
            hintText: tr(widget.hintText!),
            hintStyle: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.greyC4C4C4,
            ),
            suffixIcon: widget.suffixIcon != null
                ? Padding(padding: EdgeInsets.only(right: 12.w), child: widget.suffixIcon)
                : null,
            suffixIconConstraints: BoxConstraints(minWidth: 15.w, minHeight: 15.h),
            isDense: true,
          ),
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.black,
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
