import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO: CHECK
class AppSwitchWidget extends StatefulWidget {
  final Function(bool value) onPressed;
  final Color activeColor;
  final Color inactiveColor;
  final bool value;
  final String? label;

  const AppSwitchWidget({
    super.key,
    required this.onPressed,
    required this.activeColor,
    required this.inactiveColor,
    required this.value,
    this.label = "",
  });

  @override
  State<AppSwitchWidget> createState() => _AppSwitchWidgetState();
}

class _AppSwitchWidgetState extends State<AppSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.label?.isNotEmpty == true) ...[
          AppTextWidget(
            text: widget.label!,
            textStyle: AppStyle.bold14black.copyWith(
              color: AppColors.black3B3B3B,
            ),
          ),
          SizedBox(width: 8.h),
        ],
        GestureDetector(
          onTap: () {
            widget.onPressed(!widget.value);
          },
          child: Container(
            width: 52.w,
            height: 32.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.value ? widget.activeColor : widget.inactiveColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 2.w),
              child: Container(
                alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
