import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../data/response/message_response.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.item});

  final MessageModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 30.0, left: 30.0).r,
      child: Row(
        mainAxisAlignment:
            item.senderType == "user" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            width: 265.w,
            padding: const EdgeInsets.all(13).r,
            decoration: BoxDecoration(
                color: item.senderType == "user"
                    ? const Color(0xFFE9E9E9)
                    : const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(15),
                  topLeft: const Radius.circular(15),
                  bottomRight:
                      item.senderType != "user" ? const Radius.circular(15) : Radius.zero,
                  bottomLeft:
                      item.senderType == "user" ? const Radius.circular(15) : Radius.zero,
                )),
            child: !item.isFile
                ? DrawableText(
                    text: item.body,
                    matchParent: true,
                  )
                : ImageMultiType(
                    url: item.body,
                    height: 250.0.r,
                    width: 150.0.r,
                  ),
          )
        ],
      ),
    );
  }
}
