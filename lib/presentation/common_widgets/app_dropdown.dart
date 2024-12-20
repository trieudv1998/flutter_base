import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDropDownWidget extends StatefulWidget {
  const AppDropDownWidget({
    super.key,
    this.value,
    required this.items,
    this.hintText,
    this.label,
    this.enabled = true,
    required this.onChanged,
    this.dropDownKey,
    this.isRequired = false,
    this.validator,
  });

  final String? value;
  final List<String> items;
  final String? hintText;
  final String? label;
  final bool enabled;
  final Function(String? value) onChanged;
  final GlobalKey? dropDownKey;
  final bool isRequired;
  final String? validator;

  @override
  State<AppDropDownWidget> createState() => _AppDropDownWidgetState();
}

class _AppDropDownWidgetState extends State<AppDropDownWidget> {
  bool isDropdownOpened = false; // Biến trạng thái mở/đóng dropdown
  void toggleDropdown() {
    setState(() {
      isDropdownOpened = !isDropdownOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Row(
            children: [
              AppTextWidget(
                text: widget.label!,
                textStyle: AppStyle.bold14black.copyWith(
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
        DropdownButtonFormField2(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.w),
              borderSide: const BorderSide(
                color: AppColors.grey300,
              ),
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
            suffixIcon: Padding(
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                !isDropdownOpened ? "assets/icons/arrow-bottom.svg" : "assets/icons/ic_arrow_top.svg",
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
          onMenuStateChange: (isOpened) {
            setState(() {
              isDropdownOpened = isOpened;
            });
          },
          isExpanded: true,
          hint: AppTextWidget(
            text: widget.hintText!,
            textStyle: AppStyle.medium14black.copyWith(
              color: AppColors.greyC4C4C4,
            ),
          ),
          items: widget.items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: AppTextWidget(
                    text: item,
                    textStyle: AppStyle.medium14black,
                  ),
                  onTap: () {
                    isDropdownOpened = !isDropdownOpened;
                  },
                ),
              )
              .toList(),
          value: widget.value,
          iconStyleData: const IconStyleData(
            icon: SizedBox(),
          ),
          onChanged: (value) {
            widget.onChanged(value);
            isDropdownOpened = false;
          },
          dropdownStyleData: DropdownStyleData(
            // width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            offset: const Offset(0, -5),
            scrollbarTheme: const ScrollbarThemeData(
              radius: Radius.circular(40),
              // thickness: MaterialStateProperty.all<double>(6),
              // thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
          ),
          style: AppStyle.medium14black,
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
