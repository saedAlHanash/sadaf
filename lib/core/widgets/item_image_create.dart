import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:sadaf/core/api_manager/api_service.dart';

import '../../../../core/util/pick_image_helper.dart';
import 'package:image_multi_type/image_multi_type.dart';

class ItemImageCreate extends StatelessWidget {
  const ItemImageCreate({
    super.key,
    required this.image,
    required this.onLoad,
  });

  final dynamic image;
  final Function(Uint8List bytes) onLoad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: InkWell(
        onTap: () async {
          final image = await PickImageHelper().pickImageBytes();
          if (image == null) return;
          onLoad.call(image);
        },
        child: SizedBox(
          height: 100.0.r,
          width: 100.0.r,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleImageWidget(url: image),
              const ImageMultiType(url: Icons.edit, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
