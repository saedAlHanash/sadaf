import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/product/ui/widget/related_product_widget.dart';

class DescriptionProductScreen extends StatelessWidget {
  const DescriptionProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                text: s,
                color: Colors.grey,
              ),
            ),
          ),
          const RelatedProductWidget(),
        ],
      ),
    );
  }
}

String s =
    'It is a long established fact that a reader will be distracted by the readable content'
    ' of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, '
    'making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,'
    ' and a search for lorem ipsum will uncover many web sites still in their infancy.'
    ' Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
    'It is a long established fact that a reader will be distracted by the readable content'
    ' of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, '
    'making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,'
    ' and a search for lorem ipsum will uncover many web sites still in their infancy.'
    ' Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
    'It is a long established fact that a reader will be distracted by the readable content'
    ' of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, '
    'making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,'
    ' and a search for lorem ipsum will uncover many web sites still in their infancy.'
    ' Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).';
