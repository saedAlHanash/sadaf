import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/features/home/ui/widget/filter_widget.dart';
import 'package:sadaf/features/product/bloc/products_cubit/products_cubit.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../product/data/request/product_filter_request.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({super.key});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  void searchAction(String val) {
    Navigator.pushNamed(
      context,
      RouteName.products,
      arguments: ProductFilterRequest(search: val),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    return Container(
      height: 45.0.h,
      padding: const EdgeInsets.only(top: 8.0),
      color: Colors.black26,
      child: MyEditTextWidgetWhite(
        controller: searchC,
        backgroundColor: Colors.transparent,
        radios: 0.0,
        icon: InkWell(
          onTap: () {
            var val = searchC.text;
            searchAction(val);
            searchC.text = '';
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
            child: const ImageMultiType(
              url: Assets.iconsSearch,
              color: Colors.white54,
            ),
          ),
        ),
        hint: S.of(context).search_In_All,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (val) {
          searchC.text = '';
          searchAction(val);
          searchC.text = '';
        },
      ),
    );
  }
}

class SearchProductsWidget extends StatefulWidget {
  const SearchProductsWidget({super.key});

  @override
  State<SearchProductsWidget> createState() => _SearchProductsWidgetState();
}

class _SearchProductsWidgetState extends State<SearchProductsWidget> {
  late final TextEditingController searchC;
  late final ProductsCubit productCubit;

  @override
  void initState() {
    productCubit = context.read<ProductsCubit>();
    searchC = TextEditingController()..text = productCubit.state.request.search ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45.0.h,
            padding: const EdgeInsets.only(top: 10.0).r,
            color: AppColorManager.lightGray,
            child: MyEditTextWidget(
              controller: searchC,
              backgroundColor: Colors.transparent,
              radios: 0.0,
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                child: const ImageMultiType(
                  url: Assets.iconsSearch,
                  color: AppColorManager.gray,
                ),
              ),
              hint: S.of(context).search_In_All,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (val) => productCubit
                ..setSearchQ = val
                ..getProducts(),
            ),
          ),
        ),
        20.0.horizontalSpace,
        Container(
          color: AppColorManager.lightGray,
          child: IconButton(
            onPressed: () {
              NoteMessage.showBottomSheet1(
                  context,
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: productCubit),
                    ],
                    child: FilterWidget(),
                  ));
            },
            icon: const ImageMultiType(url: Icons.filter_alt_sharp),
          ),
        ),
      ],
    );
  }
}
