import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/settings/data/request/update_user_request.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../bloc/update_user_cubit/update_user_cubit.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.updateType});

  final UpdateType updateType;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final user = AppSharedPreference.getUserModel();
  late UpdateUserRequest request;

  @override
  void initState() {
    request = UpdateUserRequest(updateType: widget.updateType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: widget.updateType.getName),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<UpdateUserCubit, UpdateUserInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (context, state) {
              NoteMessage.showDoneDialog(
                context,
                text: state.result,
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
                text: 'حفظ التغييرات',
                onTap: () {
                  if (request.updateType == UpdateType.phone) {
                    var r = request.phone.checkPhoneNumber(context, request.phone);
                    if (r == null) return null;
                    request.phone = r;
                  }
                  return context
                      .read<UpdateUserCubit>()
                      .update(context, request: request);
                },
              );
            },
          ),
          240.0.verticalSpace,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          children: [
            if (widget.updateType == UpdateType.name)
              Column(
                children: [
                  MyTextFormNoLabelWidget(
                    label: 'الاسم',
                    onChanged: (val) => request.name = val,
                    initialValue: user.name,
                  )
                ],
              ),
            if (widget.updateType == UpdateType.phone)
              Column(
                children: [
                  MyTextFormNoLabelWidget(
                    label: 'رقم الهاتف',
                    onChanged: (val) => request.phone = val,
                    initialValue: user.phone,
                  )
                ],
              ),
            if (widget.updateType == UpdateType.address)
              Column(
                children: [
                  MyTextFormNoLabelWidget(
                    label: 'عنوان المنزل',
                    onChanged: (val) => request.address = val,
                    initialValue: user.address,
                  ),
                  MyTextFormNoLabelWidget(
                    label: 'المنطقة',
                    onChanged: (val) => request.city = val,
                    initialValue: user.city,
                  ),
                  MyTextFormNoLabelWidget(
                    label: 'المحافظة',
                    onChanged: (val) => request.country = val,
                    initialValue: user.country,
                  ),
                ],
              ),
            if (widget.updateType == UpdateType.pass)
              Column(
                children: [
                  MyTextFormNoLabelWidget(
                    label: 'اكتب كلمه المرور الحالية',
                    onChanged: (val) => request.oldPass = val,
                  ),
                  MyTextFormNoLabelWidget(
                    obscureText: true,
                    label: 'اكتب كلمه المرور الجديدة',
                    onChanged: (val) => request.newPass = val,
                  ),
                  MyTextFormNoLabelWidget(
                    obscureText: true,
                    label: 'تأكيد كلمه المرور الجديدة',
                    onChanged: (val) => request.rePass = val,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
