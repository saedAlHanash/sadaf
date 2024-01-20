import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';


import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../widget/item_category.dart';
import '../../../home/ui/widget/search_widget.dart';
import '../../../product/ui/widget/item_product.dart';

import '../../data/response/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: ""),

    );
  }
}

