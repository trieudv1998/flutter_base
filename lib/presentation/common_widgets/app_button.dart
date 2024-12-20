import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, required this.title, required this.onPressed, this.titleColor, this.backgroundColor});
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: 1.sw,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.primary900,
          borderRadius: BorderRadius.circular(50.w),
        ),
        child: AppTextWidget(
          text: widget.title,
          textStyle: AppStyle.bold14black.copyWith(
            color: widget.titleColor ?? AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
