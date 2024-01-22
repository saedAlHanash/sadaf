import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/pick_image_helper.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/chat/bloc/add_message_cubit/add_message_cubit.dart';
import 'package:sadaf/features/chat/data/request/message_request.dart';
import 'package:sadaf/features/chat/data/response/message_response.dart';
import 'package:sadaf/features/chat/ui/widget/chat_item.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/chat_messages_cubit/chat_messages_cubit.dart';
import '../../data/response/support_message_response.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key, required this.room});

  final Room room;

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final textController = TextEditingController();
  late final AddMessageCubit addMessageCubit;

  @override
  void initState() {
    addMessageCubit = context.read<AddMessageCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMessageCubit, AddMessageInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        if (state.request.message != null) textController.clear();
        context.read<MessagesCubit>().addMessageLocal(
              MessageModel.fromJson(
                {
                  'body':
                      state.request.message ?? state.request.file.firstOrNull?.fileBytes,
                  'is_file': state.request.message == null,
                },
              ),
            );
        context.read<MessagesCubit>().getRoomMessages(mId: widget.room.id);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget(titleText: '${S.of(context).support} ${widget.room.id}'),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessagesCubit, MessagesInitial>(
                builder: (context, state) {
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      return ChatItem(item: state.result[i]);
                    },
                    itemCount: state.result.length,
                  );
                },
              ),
            ),
            20.verticalSpace,
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                child: Row(
                  children: [
                    BlocBuilder<AddMessageCubit, AddMessageInitial>(
                      buildWhen: (p, c) => c.request.file.isNotEmpty,
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return InkWell(
                            onTap: () async {
                              final image = await PickImageHelper()
                                  .pickImage(removeLatestImage: true);

                              if (image != null && mounted) {
                                final request = MessageRequest();

                                request.file.add(
                                  UploadFile(
                                      nameField: 'file',
                                      fileBytes: await image.readAsBytes()),
                                );

                                addMessageCubit.addSupportMessage(
                                    mId: widget.room.id, request: request);
                              }
                            },
                            child: const ImageMultiType(url: Icons.camera_alt));
                      },
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: TextFormField(
                          controller: textController,
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) return;

                            addMessageCubit.addSupportMessage(
                                mId: widget.room.id,
                                request: MessageRequest(message: value));
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 5).r,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<AddMessageCubit, AddMessageInitial>(
                      buildWhen: (p, c) => c.request.message != null,
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return IconButton(
                          onPressed: () {
                            final value = textController.text;
                            if (value.isEmpty) return;

                            addMessageCubit.addSupportMessage(
                              mId: widget.room.id,
                              request: MessageRequest(message: value),
                            );
                          },
                          icon: const Icon(Icons.send),
                          color: Colors.black,
                          iconSize: 28,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
