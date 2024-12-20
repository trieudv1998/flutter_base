import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future showAppDialog(
  BuildContext context, {
  Function? onPressNegative,
  Function? onPressPositive,
  Function? onHide,
  String? urlIcon,
  String? title,
  double? widthIcon,
  double? heightIcon,
  Widget? content,
  bool? hideNegativeButton = false,
  bool? hidePositiveButton = false,
  Color? backgroundPositiveButton,
  Color? borderNegativeButton,
  Color? colorTitle,
  String? textNegative,
  String? textPositive,
  double? marginButton,
  bool? showCloseButton,
  bool? barrierDismissible = true,
  bool? preventBack,
  Color? colorTextNegative,
  Color? colorTextPositive,
}) async {
  final result = await showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      contentPadding: EdgeInsets.zero,
      content: PopScope(
        canPop: !(preventBack ?? false), // Here we directly evaluate the bool value
        // onPopInvokedWithResult: (isCanceled, result) {
        //   if (isCanceled) {
        //     Navigator.of(context).pop(result); // Use the result if needed
        //   }
        // },
        child: DialogWidget(
          title: title ?? '',
          urlIcon: urlIcon,
          textNegative: textNegative,
          textPositive: textPositive,
          content: content,
          colorTitle: colorTitle,
          widthIcon: widthIcon,
          marginButton: marginButton,
          heightIcon: heightIcon,
          hidePositiveButton: hidePositiveButton,
          backgroundPositiveButton: backgroundPositiveButton,
          borderNegativeButton: borderNegativeButton,
          onPressNegative: onPressNegative,
          hideNegativeButton: hideNegativeButton,
          onPressPositive: onPressPositive,
          showCloseButton: showCloseButton,
          colorTextNegative: colorTextNegative,
          colorTextPositive: colorTextPositive,
        ),
      ),
    ),
  );
  onHide?.call();
  return result;
}

class DialogWidget extends StatelessWidget {
  final String title;
  final Widget? content;
  final String? urlIcon;
  final double? widthIcon;
  final double? heightIcon;
  final String? textNegative;
  final String? textPositive;
  final Color? colorTitle;
  final bool? hideNegativeButton;
  final Function? onPressNegative;
  final bool? hidePositiveButton;
  final double? marginButton;
  final Function? onPressPositive;
  final Color? backgroundPositiveButton;
  final Color? borderNegativeButton;
  final bool? showCloseButton;
  final Color? colorTextNegative;
  final Color? colorTextPositive;

  const DialogWidget({
    Key? key,
    required this.title,
    this.content,
    this.marginButton,
    this.urlIcon,
    this.hidePositiveButton,
    this.textNegative,
    this.colorTitle,
    this.widthIcon,
    this.heightIcon,
    this.textPositive,
    this.hideNegativeButton = false,
    this.backgroundPositiveButton,
    this.borderNegativeButton,
    this.onPressNegative,
    this.onPressPositive,
    this.showCloseButton = true,
    this.colorTextNegative,
    this.colorTextPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utils.getScreenWidth(context),
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20.w,
          ),
          showCloseButton ?? false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SvgPicture.asset('assets/icons/icon_close.svg'),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          urlIcon != null
              ? SvgPicture.asset(
                  urlIcon!,
                  width: widthIcon ?? Utils.getScreenWidth(context) * 0.17,
                  height: heightIcon ?? Utils.getScreenWidth(context) * 0.17,
                )
              : const SizedBox.shrink(),
          title != ''
              ? Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    tr(title),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w700, color: colorTitle ?? AppColors.black3B3B3B),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: content ?? Container(),
          ),
          hidePositiveButton ?? false
              ? Container()
              : SizedBox(
                  height: 24.w,
                ),
          hidePositiveButton ?? false
              ? Container()
              : ButtonDialog(
                  marginButton: marginButton,
                  title: textPositive ?? '',
                  backgroundColor: backgroundPositiveButton,
                  onPressed: () {
                    onPressPositive?.call();
                  },
                  textColor: colorTextPositive,
                ),
          !(hideNegativeButton ?? false)
              ? Column(
                  children: [
                    SizedBox(
                      height: 12.w,
                    ),
                    ButtonDialog(
                      marginButton: marginButton,
                      title: textNegative ?? '',
                      borderColor: AppColors.primary900,
                      backgroundColor: AppColors.white,
                      onPressed: () {
                        onPressNegative?.call();
                      },
                      textColor: colorTextNegative,
                    )
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class ButtonDialog extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? marginButton;
  final Color? textColor;
  const ButtonDialog(
      {Key? key,
      required this.title,
      this.borderColor,
      this.onPressed,
      this.marginButton,
      this.titleColor,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: marginButton ?? 18.w),
          padding: EdgeInsets.symmetric(vertical: 12.w),
          decoration: BoxDecoration(
            border: Border.all(
                color: borderColor != null
                    ? borderColor!
                    : backgroundColor != null
                        ? backgroundColor!
                        : AppColors.white),
            color: backgroundColor ?? AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(100.w)),
          ),
          child: Center(
            child: Text(
              tr(title),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: textColor ?? AppColors.white),
            ),
          )),
    );
  }
}
