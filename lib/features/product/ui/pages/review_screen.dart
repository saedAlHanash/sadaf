import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../widget/item_review_widget.dart';

class ReviewProductScreen extends StatelessWidget {
  const ReviewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
        builder: (context, state) {
          if (state.result.reviews.isEmpty) {
            return NotFoundWidget(
              text: S.of(context).emptyReview,
              icon: Assets.iconsNoSearchResult,
            );
          }
          return ListView.builder(
            itemCount: state.result.reviews.length,
            itemBuilder: (_, i) {
              return ItemReviewWidget(review: state.result.reviews[i]);
            },
          );
        },
      ),
    );
  }
}
