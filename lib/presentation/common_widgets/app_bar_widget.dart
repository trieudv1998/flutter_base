import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/app_text_style.dart';
import 'package:flutter_base/presentation/common_widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isShowBackButton;
  final String titleAppBar;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  const AppBarWidget(
      {super.key, required this.titleAppBar, this.backgroundColor, this.isShowBackButton = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? AppColors.white,
      leading: isShowBackButton
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onTap != null) {
                  onTap!();
                }
              },
              icon: SvgPicture.asset(
                "assets/icons/ic_arrow_left.svg",
                width: 30.w,
                height: 30.w,
              ),
            )
          : null,
      title: AppTextWidget(
        text: titleAppBar,
        textStyle: AppStyle.bold18black,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
