import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
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

  const AppTextField({
    Key? key,
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
  }) : super(key: key);

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
          Text.rich(
            TextSpan(
              text: widget.label,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.b100,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: widget.isRequired == true ? " *" : "",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.red,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
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
            fillColor: widget.enable ? null : AppColors.b500,
            counter: const Offstage(),
            contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 13.h, bottom: 13.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.w),
              borderSide: const BorderSide(color: AppColors.b500),
            ),
            disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.b500), borderRadius: BorderRadius.circular(8.w)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.red : AppColors.b500),
              borderRadius: BorderRadius.circular(8.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.red : AppColors.main),
              borderRadius: BorderRadius.circular(8.w),
            ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.manrope(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.b500,
            ),
            suffixIcon: widget.suffixIcon != null ? Padding(padding: EdgeInsets.only(right: 5.w), child: widget.suffixIcon) : null,
            suffixIconConstraints: BoxConstraints(minWidth: 15.w, minHeight: 15.h),
            isDense: true,
          ),
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.b100,
          ),
        ),
        if (widget.validator?.isNotEmpty ?? false) ...{
          Container(
            color: AppColors.white,
            margin: EdgeInsets.only(top: 2.h),
            child: Text(
              widget.validator!,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.red,
              ),
            ),
          )
        }
      ],
    );
  }
}
