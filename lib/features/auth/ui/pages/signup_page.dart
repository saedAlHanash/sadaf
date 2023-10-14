import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/core/widgets/select_date.dart';
import 'package:sadaf/features/auth/data/request/signup_request.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';
import '../widget/ask_auth_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final request = SignupRequest();
  final _formKey = GlobalKey<FormState>();

  final bDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        NoteMessage.showDoneDialog(
          context,
          text: 'تم إنشاء الحساب',
          onCancel: () => Navigator.pushReplacementNamed(context, RouteName.login),
        );
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                19.verticalSpace,
                DrawableText.header(text: S.of(context).signUp),
                30.verticalSpace,

                MyTextFormOutLineWidget(
                  validator: (p0) {
                    if (request.name.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  initialValue: request.name,
                  label: S.of(context).name,
                  onChanged: (val) => request.name = val,
                ),

                MyTextFormOutLineWidget(
                  validator: (p0) {
                    if (request.name.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: bDateController,
                  enable: false,
                  label: S.of(context).birthday,
                  iconWidget: SelectSingeDateWidget(
                    initial: request.birthday,
                    maxDate: DateTime.now(),
                    minDate: DateTime(1900),
                    onSelect: (selected) {
                      request.birthday = selected;
                      bDateController.text = selected?.formatDate ?? '';
                    },
                  ),
                ),
                // رقم الهاتف
                MyTextFormOutLineWidget(
                  validator: (p0) {
                    if (request.phoneNumber.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  initialValue: request.phoneNumber,
                  maxLength: 11,
                  label: '${S.of(context).email} - ${S.of(context).phoneNumber}',
                  onChanged: (val) => request.phoneNumber = val,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  validator: (p0) {
                    if (request.password.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  label: S.of(context).password,
                  obscureText: true,
                  onChanged: (val) => request.password = val,
                  textDirection: TextDirection.ltr,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  validator: (p0) {
                    if (request.rePassword != request.password) {
                      return '';
                    }
                    return null;
                  },
                  label: S.of(context).rePassword,
                  obscureText: true,
                  onChanged: (val) => request.rePassword = val,
                  textDirection: TextDirection.ltr,
                ),

                MyButton(
                  text: S.of(context).signUp,
                  onTap: () {
                    if (!_formKey.currentState!.validate()) return;
                    if (/*request.validateFirst(context)*/ true) {
                      Navigator.pushNamed(
                        context,
                        RouteName.confirmCode,
                        arguments: request,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
