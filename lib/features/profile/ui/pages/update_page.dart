import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/profile/ui/widget/top_profile_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';

import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/request/update_profile_request.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.updateType});

  final UpdateType updateType;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final user = AppSharedPreference.getUserModel;
  late UpdateProfileRequest request;
  late final UpdateProfileCubit updateCubit;

  @override
  void initState() {
    updateCubit = context.read<UpdateProfileCubit>();
    request = updateCubit.state.request;
    request.type = widget.updateType;
    request.avatar = UploadFile(initialImage: user.avatar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: SingleChildScrollView(
        child: TopProfileWidget(
          onLoad: (bytes) {
            setState(() {
              request.avatar = request.avatar!.copyWith(fileBytes: bytes);
            });
          },
          file: request.avatar,
          title: widget.updateType.getName,
          children: [
            if (widget.updateType == UpdateType.name)
              MyTextFormOutLineWidget(
                label: S.of(context).name,
                onChanged: (val) => updateCubit.setName = val,
                initialValue: request.name,
              ),
            if (widget.updateType == UpdateType.phone)
              MyTextFormOutLineWidget(
                label: S.of(context).phoneNumber,
                onChanged: (val) => updateCubit.setEmailOrPhone = val,
                initialValue: request.emailOrPhone,
              ),
            if (widget.updateType == UpdateType.email)
              MyTextFormOutLineWidget(
                label: S.of(context).email,
                onChanged: (val) => updateCubit.setEmailOrPhone = val,
                initialValue: request.emailOrPhone,
              ),
            if (widget.updateType == UpdateType.address)
              Column(
                children: [
                  MyTextFormOutLineWidget(
                    label: S.of(context).yourAddress,
                    onChanged: (val) => updateCubit.setHomeAddress = val,
                    initialValue: user.home,
                  ),
                  MyTextFormOutLineWidget(
                    label: S.of(context).city,
                    onChanged: (val) => updateCubit.setCity = val,
                    initialValue: user.city,
                  ),
                  MyTextFormOutLineWidget(
                    label: S.of(context).country,
                    onChanged: (val) => updateCubit.setCountry = val,
                    initialValue: user.country,
                  ),
                ],
              ),
            if (widget.updateType == UpdateType.pass)
              Column(
                children: [
                  MyTextFormOutLineWidget(
                    label: S.of(context).currentPassword,
                    onChanged: (val) => request.oldPass = val,
                  ),
                  MyTextFormOutLineWidget(
                    obscureText: true,
                    label: S.of(context).newPassword,
                    onChanged: (val) => request.newPass = val,
                  ),
                  MyTextFormOutLineWidget(
                    obscureText: true,
                    label: S.of(context).confirmNewPassword,
                    onChanged: (val) => request.rePass = val,
                  ),
                ],
              ),
            BlocConsumer<UpdateProfileCubit, UpdateProfileInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) {
                NoteMessage.showAwesomeDoneDialog(
                  context,
                  message: '',
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
              },
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  text: S.of(context).saveChange,
                  onTap: () {
                    return updateCubit.updateProfile();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
