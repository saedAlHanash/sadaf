import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/response/message_item.dart';
import 'media_item.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.item});

  final MessageModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 30.0, left: 30.0).r,
      child: Row(
        mainAxisAlignment:
            item.senderType == "driver" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            width: 265.w,
            padding: const EdgeInsets.all(13).r,
            decoration: BoxDecoration(
                color: item.senderType == "driver"
                    ? const Color(0xFFE9E9E9)
                    : const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(15),
                  topLeft: const Radius.circular(15),
                  bottomRight: item.senderType != "driver"
                      ? const Radius.circular(15)
                      : Radius.zero,
                  bottomLeft: item.senderType == "driver"
                      ? const Radius.circular(15)
                      : Radius.zero,
                )),
            child: !item.isFile
                ? Text(item.body)
                : MediaChatItem(
                    item: item,
                  ),
          )
        ],
      ),
    );
  }
}
