import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';

import '../../bloc/select_option_cubit/select_option_cubit.dart';
import '../../data/response/products_response.dart';

class SizeOptions extends StatefulWidget {
  const SizeOptions({super.key, required this.options});

  final List<String> options;

  @override
  State<SizeOptions> createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  final controller = GroupButtonController();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (widget.options.isNotEmpty) {
          controller.selectIndex(0);
          context.read<SelectOptionCubit>().selectSize(widget.options[0]);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 1.0.sw,
      child: GroupButton(
        controller: controller,
        onSelected: (value, i, _) {
          context.read<SelectOptionCubit>().selectSize(value);
        },
        // buttonBuilder: (selected, value, context) {
        //   return Container(
        //     width: 100.0.w,
        //     decoration: BoxDecoration(
        //         color: selected ? AppColorManager.mainColor : Colors.white,
        //         border: Border.all(color: AppColorManager.gray)),
        //     child: DrawableText(
        //       text: 'value',
        //       textAlign: TextAlign.center,
        //       matchParent: true,
        //       color: selected ? Colors.white : AppColorManager.mainColor,
        //     ),
        //   );
        // },
        options: GroupButtonOptions(
          buttonHeight: 28.0.h,
          buttonWidth: 85.0.w,
          direction: Axis.horizontal,
          mainGroupAlignment: MainGroupAlignment.start,
          elevation: 0.0,
          selectedTextStyle: TextStyle(color: Colors.black),
          unselectedShadow: [],
          selectedBorderColor: AppColorManager.lightGrayEd,
          unselectedBorderColor: AppColorManager.d9,
        ),
        buttons: widget.options.map((e) => e).toList(),
      ),
    );
  }
}

class ColorOptions extends StatefulWidget {
  const ColorOptions({super.key, required this.colors});

  final List<String> colors;

  @override
  State<ColorOptions> createState() => _ColorOptionsState();
}

class _ColorOptionsState extends State<ColorOptions> {
  final controller = GroupButtonController();
  final disableIndexes = <int>[];
  late final Product product;
  var rejectSelect = false;

  @override
  void initState() {
    product = context.read<SelectOptionCubit>().state.product;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        disableColors();
      },
    );
    super.initState();
  }

  void disableColors() {
    disableIndexes.clear();
    final selectedSize = context.read<SelectOptionCubit>().state.selectedSize;
    widget.colors.forEachIndexed((i, color) {
      final b = product.groupedOptions[selectedSize]
              ?.firstWhereOrNull((e) => e.color.hex == color) ==
          null;

      if (b) disableIndexes.add(i);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectOptionCubit, SelectOptionInitial>(
      listenWhen: (p, c) => p.selectedSize != c.selectedSize,
      listener: (context, state) {
        controller.unselectAll();
        rejectSelect = false;
        disableColors();
      },
      child: Column(
        children: [
          SizedBox(
            width: 1.0.sw,
            child: GroupButton(
              controller: controller,
              isRadio: true,
              onSelected: (value, i, _) {
                if (disableIndexes.contains(i)) {
                  setState(() {
                    rejectSelect = true;
                    controller.unselectIndex(i);
                  });
                  return;
                } else {
                  setState(() {
                    rejectSelect = false;
                  });
                }
                final selectedSize = context.read<SelectOptionCubit>().state.selectedSize;
                final selectedColor = value;
                final option =
                    product.groupedOptions[selectedSize]?.firstWhereOrNull((element) {
                  return element.color.hex == selectedColor;
                });

                if (option != null) {
                  context
                      .read<SelectOptionCubit>()
                      .selectColor(option.id, option.thumbnail, option);
                }
              },
              buttonBuilder: (selected, value, context) {
                final color = getColorFromHex(value);
                return Container(
                  height: 50.0.r,
                  width: 50.0.r,
                  padding: const EdgeInsets.all(5.0).r,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: Border.all(color: AppColorManager.lightGray)),
                  child: selected
                      ? ImageMultiType(
                          url: Icons.check,
                          color: getCheckColor(color),
                        )
                      : null,
                );
              },
              options: GroupButtonOptions(
                buttonHeight: 28.0.h,
                buttonWidth: 85.0.w,
                direction: Axis.horizontal,
                mainGroupAlignment: MainGroupAlignment.start,
                elevation: 0.0,
                unselectedShadow: [],
                selectedBorderColor: AppColorManager.mainColor,
                unselectedBorderColor: AppColorManager.d9,
              ),
              buttons: widget.colors.map((e) => e).toList(),
            ),
          ),
          10.0.verticalSpace,
          if (rejectSelect)
            DrawableText(
                matchParent: true,
                size: 14.0.sp,
                text: 'This Color Is Currently Not Available',
                color: AppColorManager.red),
        ],
      ),
    );
  }
}
