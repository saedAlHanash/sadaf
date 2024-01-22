import 'package:flutter/material.dart';

import '../../data/response/message_item.dart';

class MediaChatItem extends StatelessWidget {
  const MediaChatItem({super.key, required this.item});

  final MessageModel item;

  @override
  Widget build(BuildContext context) {
    return _isImage()
        ? Image.network(item.body)
        : _isPDF()
        ? InkWell(
        onTap: () {
          // openUrl(item.body);
        },
        child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Icon_pdf_file.svg/1200px-Icon_pdf_file.svg.png"))
        : const SizedBox();
  }

  bool _isImage() {
    String fileType = item.body.split(".").last;

    return (fileType.toLowerCase() == "jpeg" || fileType.toLowerCase() == "png") ||
        fileType.toLowerCase() == "jpg";
  }

  bool _isPDF() {
    String fileType = item.body.split(".").last;
    return fileType.toLowerCase() == "pdf";
  }
}
