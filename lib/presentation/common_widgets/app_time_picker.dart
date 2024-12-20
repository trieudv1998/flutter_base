import 'package:flutter/cupertino.dart';

class AppTimePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final void Function(DateTime)? onChange;

  const AppTimePicker({
    super.key,
    this.selectedDate,
    this.minimumDate,
    this.maximumDate,
    this.onChange,
  });

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoDatePicker(
        initialDateTime: widget.selectedDate ??
            DateTime.now().add(
              Duration(minutes: 15 - DateTime.now().minute % 15),
            ),
        mode: CupertinoDatePickerMode.time,
        use24hFormat: true,
        minuteInterval: 15,
        minimumDate: widget.minimumDate,
        maximumDate: widget.maximumDate,
        onDateTimeChanged: (dateTime) {
          widget.onChange?.call(dateTime);
        },
      ),
    );
  }
}
