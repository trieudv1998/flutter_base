import 'package:flutter/material.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
import 'package:flutter_base/core/domain/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future showCustomDialog(
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
    }) async {
  final result = await showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.transparent,
      //   scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      contentPadding: EdgeInsets.zero,
      content: WillPopScope(
        onWillPop: preventBack != null ? () async => !preventBack : null,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utils.getScreenWidth(context),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.w)),
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
            padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 24.w,
                bottom: 8.w),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: colorTitle ?? AppColors.b100),
            ),
          )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                borderColor: AppColors.b400,
                backgroundColor: AppColors.white,
                onPressed: () {
                  onPressNegative?.call();
                },
              )
            ],
          )
              : const SizedBox(),
          SizedBox(
            height: 32.w,
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

  const ButtonDialog(
      {Key? key,
        required this.title,
        this.borderColor,
        this.onPressed,
        this.marginButton,
        this.titleColor,
        this.backgroundColor})
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
          margin: EdgeInsets.symmetric(
              horizontal: marginButton ?? Utils.getScreenWidth(context) * 0.14),
          padding: EdgeInsets.symmetric(vertical: 12.w),
          decoration: BoxDecoration(
            border: Border.all(
                color: borderColor != null
                    ? borderColor!
                    : backgroundColor != null
                    ? backgroundColor!
                    : AppColors.y300),
            color: backgroundColor ?? AppColors.y300,
            borderRadius:
            BorderRadius.all(Radius.circular(100.w)),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.b100),
            ),
          )),
    );
  }
}
