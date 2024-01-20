import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../widget/item_review_widget.dart';

class ReviewProductScreen extends StatelessWidget {
  const ReviewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
      builder: (context, state) {
        if (state.result.reviews.isEmpty) return 0.0.verticalSpace;
        return ListView.builder(
          itemCount: state.result.reviews.length,
          itemBuilder: (_, i) {
            return ItemReviewWidget(review: state.result.reviews[i]);
          },
        );
      },
    );
  }
}
