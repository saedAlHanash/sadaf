import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../categories/ui/widget/list_categories_filter.dart';
import '../../../colors/bloc/colors_cubit/colors_cubit.dart';
import '../../../colors/ui/widget/item_color.dart';
import '../../../product/bloc/products_cubit/products_cubit.dart';
import '../../../product/data/request/product_filter_request.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      constraints: BoxConstraints(maxHeight: .8.sh),
      padding: const EdgeInsets.all(30.0).r,
      decoration: const BoxDecoration(
        color: AppColorManager.lightGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawableText(text: S.of(context).filters, matchParent: true),
            25.0.verticalSpace,
            const ListCategoriesFilter(),
            25.0.verticalSpace,
            DrawableText(text: S.of(context).price, matchParent: true),
            const _RangePrice(),
            25.0.verticalSpace,
            DrawableText(text: S.of(context).colors, matchParent: true),
            25.0.verticalSpace,
            const _ColorWidget(),
            25.0.verticalSpace,
            MyButton(
              text: S.of(context).apply_filters,
              onTap: () {
                Navigator.pop(context);
                context.read<ProductsCubit>().getProducts();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RangePrice extends StatefulWidget {
  const _RangePrice();

  @override
  State<_RangePrice> createState() => _RangePriceState();
}

class _RangePriceState extends State<_RangePrice> {
  late final ProductsCubit productCubit;

  @override
  void initState() {
    productCubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfRangeSelector(
          initialValues: SfRangeValues(
            productCubit.state.request.fromPrice ?? min,
            productCubit.state.request.toPrice ?? max,
          ),
          min: min,
          max: max,
          activeColor: AppColorManager.mainColorLight,
          enableTooltip: true,
          onChanged: (value) {
            setState(() {
              productCubit.setFromPrice = value.start;
              productCubit.setToPrice = value.end;
            });
          },
          stepSize: step,
          child: SizedBox(
            height: 20.0.h,
            width: 1.0.sw,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: DrawableText(
                textAlign: TextAlign.center,
                matchParent: true,
                text: (productCubit.state.request.fromPrice ?? min)
                    .toInt()
                    .toString()
                    .formatPrice,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0).w,
              color: Colors.black,
              height: 1.0.h,
              width: 70.0.w,
            ),
            Expanded(
              child: DrawableText(
                textAlign: TextAlign.center,
                matchParent: true,
                text: (productCubit.state.request.toPrice ?? max)
                    .toInt()
                    .toString()
                    .formatPrice,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ColorWidget extends StatefulWidget {
  const _ColorWidget();

  @override
  State<_ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  late final ProductsCubit productCubit;

  @override
  void initState() {
    productCubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorsCubit, ColorsInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if (state.result.isEmpty) return 0.0.verticalSpace;
        return SizedBox(
          height: 40.0.h,
          width: 1.0.sw,
          child: ListView.builder(
            itemCount: state.result.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final item = state.result[i];
              return ItemColorImageWidget(
                item: item,
                selected: item.id == productCubit.state.request.colorId,
                onTap: (e) => setState(() => productCubit.setColor = e.id),
              );
            },
          ),
        );
      },
    );
  }
}
