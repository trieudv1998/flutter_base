import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
import 'package:flutter_base/core/domain/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget extends StatelessWidget {
  final Color? color;

  const DividerWidget({
    super.key,
    this.color = AppColors.greyF2F2F7,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utils.getScreenWidth(context),
      height: 1.h,
      color: color,
    );
  }
}
