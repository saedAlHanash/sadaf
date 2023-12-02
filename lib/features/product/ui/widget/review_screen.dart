import 'package:flutter/material.dart';

import 'item_review_widget.dart';

class ReviewProductScreen extends StatelessWidget {
  const ReviewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: 10,
      itemBuilder: (_, i) {
        return ItemReviewWidget();
      },
    );
  }
}
