import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../product/data/request/product_filter_request.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SearchFieldWidget(),
          ),
          10.0.horizontalSpace,
          Container(
            height: 45.0.h,
            width: 45.0.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(.6),
              ),
            ),
            child: InkWell(
              onTap: () async {},
              child: ImageMultiType(
                url: Icons.filter_list_sharp,
                height: 30.0.r,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(.6),
        ),
      ),
      child: MyEditTextWidget(
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
              color: AppColorManager.gray,
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

class SearchOffersFieldWidget extends StatelessWidget {
  const SearchOffersFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    return Container(
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
        onFieldSubmitted: (val) {
          searchC.text = '';
        },
      ),
    );
  }
}

class SearchProductsFieldWidget extends StatefulWidget {
  const SearchProductsFieldWidget({super.key, required this.onApply, this.initialVal});

  final Function(String val) onApply;
  final String? initialVal;

  @override
  State<SearchProductsFieldWidget> createState() => _SearchProductsFieldWidgetState();
}

class _SearchProductsFieldWidgetState extends State<SearchProductsFieldWidget> {
  late final TextEditingController searchC;

  @override
  void initState() {
    searchC = TextEditingController()..text = widget.initialVal ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onFieldSubmitted: (val) {
          widget.onApply.call(val);
        },
      ),
    );
  }
}
