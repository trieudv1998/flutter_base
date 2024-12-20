import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
      {super.key, required this.text, this.textStyle, this.textAlign, this.maxLines, this.overflow, this.softWrap});
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) {
    return Text(
      tr(text),
      style: textStyle?.copyWith(
        fontSize: textStyle!.fontSize ?? 16.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
