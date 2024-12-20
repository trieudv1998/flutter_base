import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class DropdownItemEntry {
  final String label;
  final String value;

  DropdownItemEntry({
    required this.label,
    required this.value,
  });
}

class AppDropDownMultipleWidget extends StatefulWidget {
  final MultiSelectController<String> controller;
  final List<DropdownItemEntry> items;
  final String? hintText;
  final String? label;
  final bool enabled;
  final Function(List<String>?) onChanged;
  final bool isRequired;
  final String? validator;

  const AppDropDownMultipleWidget({
    super.key,
    required this.controller,
    required this.items,
    this.hintText,
    this.label,
    this.enabled = true,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
  });

  @override
  State<AppDropDownMultipleWidget> createState() => _AppDropDownMultipleWidgetState();
}

class _AppDropDownMultipleWidgetState extends State<AppDropDownMultipleWidget> {
  // final controller = MultiSelectController<String>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
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
        ],
        MultiDropdown(
          items: widget.items
              .map((item) => DropdownItem(
                    value: item.value,
                    label: item.label,
                  ))
              .toList(),
          controller: widget.controller,
          enabled: true,
          // searchEnabled: true,
          chipDecoration: const ChipDecoration(
            backgroundColor: AppColors.primary800,
            wrap: true,
            runSpacing: 2,
            spacing: 10,
          ),
          fieldDecoration: FieldDecoration(
            suffixIcon: IconButton(
              iconSize: 24.w,
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/arrow-bottom.svg",
                width: 24.w,
                height: 24.w,
              ),
            ),
            hintText: tr(widget.hintText ?? ''),
            hintStyle: AppStyle.medium14black.copyWith(
              color: AppColors.grey300,
            ),
            showClearIcon: true,
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.danger500 : AppColors.grey200),
              borderRadius: BorderRadius.circular(8.w),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.grey500), borderRadius: BorderRadius.circular(8.w)),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: (widget.validator?.isNotEmpty ?? false) ? AppColors.danger500 : AppColors.grey200),
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          dropdownDecoration: const DropdownDecoration(
            marginTop: 2,
            maxHeight: 300,
          ),
          dropdownItemDecoration: const DropdownItemDecoration(
            selectedIcon: Icon(Icons.check_box, color: AppColors.success500),
            disabledIcon: Icon(Icons.lock, color: AppColors.grey300),
          ),
          validator: (value) {
            return null;
          },
          onSelectionChange: (selectedItems) {
            widget.onChanged(selectedItems);
          },
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
