import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:sadaf/core/widgets/spinner_widget.dart';

import '../strings/app_color_manager.dart';

class MyCheckboxWidget extends StatelessWidget {
  const MyCheckboxWidget({
    Key? key,
    required this.items,
    this.buttonBuilder,
    this.onSelected,
    this.isRadio,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final bool? isRadio;
  final GroupButtonValueBuilder<SpinnerItem>? buttonBuilder;
  final Function(SpinnerItem value, int index, bool isSelected)? onSelected;

  factory MyCheckboxWidget.btn({
    required List<SpinnerItem> items,
  }) {
    return MyCheckboxWidget(
      items: items,
      isRadio: true,
      buttonBuilder: (selected, value, context) {
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0).r,
          decoration: BoxDecoration(
            color: selected ? AppColorManager.mainColor : AppColorManager.whit,
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(
              color: AppColorManager.mainColor,
              width: 1.3.spMin,
            ),
          ),
          child: DrawableText(
            text: value.name ?? '',
            maxLines: 1,
            color: selected ? AppColorManager.whit : AppColorManager.mainColor,
            size: 16.0.spMin,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GroupButton<SpinnerItem>(
      buttons: items,
      buttonBuilder: buttonBuilder ??
          (selected, value, context) {
            return InkWell(
              child: SizedBox(
                width: 0.4.sw,
                height: 40.0.h,
                child: DrawableText(
                  text: value.name ?? '',
                  maxLines: 1,
                  color: selected
                      ? AppColorManager.mainColor
                      : AppColorManager.textColor,
                  size: 16.0.spMin,
                  drawableStart: Checkbox(
                    value: selected,
                    side: BorderSide(
                        width: 1.0.spMin, color: AppColorManager.gray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.r),
                    ),
                    onChanged: null,
                  ),
                ),
              ),
            );
          },
      onSelected: onSelected,
      enableDeselect: !(isRadio ?? false),
      options: const GroupButtonOptions(
        crossGroupAlignment: CrossGroupAlignment.start,
        mainGroupAlignment: MainGroupAlignment.start,
      ),
      isRadio: isRadio ?? false,
    );
  }
}
