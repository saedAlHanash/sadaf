import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/product/ui/widget/related_product_widget.dart';

import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';

class DescriptionProductScreen extends StatelessWidget {
  const DescriptionProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
          child: Column(
            children: [
              40.0.verticalSpace,
              SizedBox(
                height: 200.0.h,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                  child: DrawableText(
                    text: state.result.description,
                    color: Colors.grey,
                  ),
                ),
              ),
              const RelatedProductWidget(),
            ],
          ),
        );
      },
    );
  }
}
