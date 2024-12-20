import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/presentation/common_widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class AppDatePickerDialog {
  final BuildContext context;
  final String? okText;
  final ChangeDateRangeCallback? onOkPressed;
  final String? cancelText;
  final VoidCallback? onCancelPressed;
  final bool dismissible;
  final VoidCallback? onDismissed;
  final bool autoDismiss;
  final bool showCloseButton;
  final double? marginHorizontal;
  final Text? headerTitle;
  DateTime startDate;
  DateTime focusedDay_;
  DateTime selectedDay_;
  DateTime? endDate;
  dynamic setStateHandle;

  AppDatePickerDialog({
    required this.context,
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.onDismissed,
    this.dismissible = false,
    this.autoDismiss = false,
    this.showCloseButton = false,
    this.marginHorizontal = 40,
    this.headerTitle,
    required this.startDate,
    required this.focusedDay_,
    required this.selectedDay_,
    this.endDate,
  });

  Timer? t;

  void show() {
    //Auto dismiss after 3 seconds
    if (autoDismiss) {
      t = Timer(const Duration(seconds: 3), () {
        dismiss();
      });
    }
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            setStateHandle = setState;
            return _buildDialog(context);
          });
        });
  }

  Widget _buildDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: GestureDetector(
          onTap: () {
            if (dismissible == true) {
              dismiss();
            }
          },
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: marginHorizontal ?? 40.w,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 15.h),
                          child: Column(
                            children: [
                              //Calendar
                              TableCalendar(
                                weekendDays: const [
                                  DateTime.sunday,
                                  DateTime.monday,
                                  DateTime.tuesday,
                                  DateTime.wednesday,
                                  DateTime.thursday,
                                  DateTime.friday,
                                  DateTime.saturday,
                                ],
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle: GoogleFonts.manrope(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.grey600,
                                )),
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2100, 3, 14),
                                focusedDay: selectedDay_,
                                selectedDayPredicate: (day) {
                                  return isSameDay(selectedDay_, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (selectedDay.isAfter(DateTime.now()) ||
                                      (selectedDay.day >= DateTime.now().day &&
                                          selectedDay.month == DateTime.now().month)) {
                                    setStateHandle(() {
                                      selectedDay_ = selectedDay;
                                      focusedDay_ = focusedDay;
                                    });
                                  }
                                },
                                onPageChanged: (focusedDay) {
                                  focusedDay_ = focusedDay;
                                },
                                locale: 'en',
                                calendarFormat: CalendarFormat.month,
                                headerStyle: HeaderStyle(
                                  // titleTextFormatter: (date, locale) => DateFormat.MMMM('en').format(date),
                                  leftChevronIcon: const Icon(
                                    Icons.chevron_left,
                                    color: AppColors.grey600,
                                  ),
                                  rightChevronIcon: const Icon(
                                    Icons.chevron_right,
                                    color: AppColors.grey600,
                                  ),
                                  leftChevronPadding: EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                    top: 12.h,
                                    bottom: 12.h,
                                  ),
                                  rightChevronPadding: EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                    top: 12.h,
                                    bottom: 12.h,
                                  ),
                                  formatButtonVisible: false,
                                  headerPadding: const EdgeInsets.only(left: 0, right: 0),
                                  headerMargin: EdgeInsets.only(bottom: 20.h),
                                  titleCentered: true,
                                  titleTextStyle: GoogleFonts.manrope(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                daysOfWeekHeight: 40,
                                calendarBuilders: CalendarBuilders(
                                  defaultBuilder: (context, datetime, focusedDay) {
                                    if (datetime.isBefore(startDate)) {
                                      return Container(
                                        width: 40.w,
                                        height: 40.w,
                                        margin: EdgeInsets.only(
                                          bottom: 4.h,
                                          top: 4.h,
                                        ),
                                        color: AppColors.white,
                                        child: Center(
                                          child: Text(
                                            datetime.day.toString(),
                                            style: GoogleFonts.manrope(
                                              color: AppColors.grey300,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return Container(
                                      width: 40.w,
                                      height: 40.w,
                                      margin: EdgeInsets.only(
                                        bottom: 4.h,
                                        top: 4.h,
                                      ),
                                      color: AppColors.white,
                                      child: Center(
                                        child: Text(
                                          datetime.day.toString(),
                                          style: GoogleFonts.manrope(
                                            color: AppColors.grey600,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  selectedBuilder: ((context, datetime, focusedDay) {
                                    return Container(
                                      width: 40.w,
                                      height: 40.w,
                                      margin: EdgeInsets.only(
                                        bottom: 4.h,
                                        top: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary900, borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Text(
                                          datetime.day.toString(),
                                          style: GoogleFonts.manrope(
                                            color: AppColors.white,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  todayBuilder: ((context, datetime, focusedDay) {
                                    return Container(
                                      width: 40.w,
                                      height: 40.w,
                                      margin: EdgeInsets.only(
                                        bottom: 4.h,
                                        top: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary400, borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Text(
                                          datetime.day.toString(),
                                          style: GoogleFonts.manrope(
                                            color: AppColors.grey600,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  outsideBuilder: ((context, datetime, focusedDay) {
                                    if (datetime.isBefore(startDate)) {
                                      return Container(
                                        width: 40.w,
                                        height: 40.w,
                                        margin: EdgeInsets.only(
                                          bottom: 4.h,
                                          top: 4.h,
                                        ),
                                        color: AppColors.white,
                                        child: Center(
                                          child: Text(
                                            datetime.day.toString(),
                                            style: GoogleFonts.manrope(
                                              color: AppColors.grey600,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return Container(
                                      width: 40.w,
                                      height: 40.w,
                                      margin: EdgeInsets.only(
                                        bottom: 4.h,
                                        top: 4.h,
                                      ),
                                      color: AppColors.white,
                                      child: Center(
                                        child: Text(
                                          datetime.day.toString(),
                                          style: GoogleFonts.manrope(
                                            color: AppColors.grey600,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildActions,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildActions {
    bool showOkButton = (okText ?? '').isNotEmpty;
    bool showCancelButton = (okText ?? '').isNotEmpty;
    List<Widget> buttons = [];

    if (showCancelButton) {
      buttons.add(_buildCancelButton);
    }
    if (showOkButton) {
      buttons.add(_buildOkButton);
    }
    if (buttons.isEmpty) {
      return Container(height: 14);
    }
    return SizedBox(
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }

  Widget get _buildOkButton {
    return SizedBox(
      width: 140.w,
      child: AppButton(
        backgroundColor: AppColors.primary900,
        title: okText ?? 'Agree',
        onPressed: () {
          onOkPressed!(selectedDay_);
          dismiss();
        },
      ),
    );
  }

  Widget get _buildCancelButton {
    return SizedBox(
        width: 140.w,
        child: AppButton(
          title: cancelText ?? "Cancel",
          titleColor: AppColors.grey50,
          onPressed: () {
            dismiss();
          },
        ));
  }

  dismiss() {
    t?.cancel();
    Navigator.of(context, rootNavigator: true).pop();
    onDismissed?.call();
  }
}

typedef ChangeDateRangeCallback = void Function(DateTime select);
