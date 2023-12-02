import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectSingeDateWidget extends StatelessWidget {
  const SelectSingeDateWidget({
    super.key,
    this.onSelect,
    this.initial,
    this.maxDate,
    this.minDate,
  });

  final DateTime? initial;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime? selected)? onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: BoxConstraints(maxHeight: 1.0.sh, maxWidth: 1.0.sw),
      splashRadius: 0.001,
      color: Colors.white,
      padding: const EdgeInsets.all(5.0).r,
      elevation: 2.0,
      iconSize: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      itemBuilder: (context) => [
        // PopupMenuItem 1
        PopupMenuItem(
          value: 1,
          enabled: false,
          // row with 2 children
          child: SizedBox(
            height: .3.sh,
            width: 0.8.sw,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SfDateRangePicker(
                  initialSelectedDate: initial,
                  maxDate: maxDate,
                  minDate: minDate,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
                    if (range.value is DateTime) {
                      onSelect?.call(range.value);
                      Navigator.pop(context);
                    } else if (range.value is PickerDateRange) {}
                  },
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
              ),
            ),
          ),
        ),
      ],
      child: Icon(
        Icons.date_range,
        size: 30.0.r,
      ),
    );
  }
}

class SelectSingeDateScrollWidget extends StatelessWidget {
  const SelectSingeDateScrollWidget({
    super.key,
    this.onSelect,
    this.initial,
    this.maxDate,
    this.minDate,
  });

  final DateTime? initial;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime? selected)? onSelect;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        var datePicked = await DatePicker.showSimpleDatePicker(
          context,
          initialDate: initial,
          firstDate: minDate,
          lastDate: maxDate,
          dateFormat: "dd-MMMM-yyyy",
          looping: true,
        );
        if (datePicked != null) onSelect?.call(datePicked);
      },
      icon: Icon(
        Icons.date_range,
        size: 30.0.r,
      ),
    );
  }
}
