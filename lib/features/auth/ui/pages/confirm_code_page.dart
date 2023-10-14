import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ConfirmCodePage extends StatefulWidget {
  const ConfirmCodePage({Key? key}) : super(key: key);

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  var phone = AppSharedPreference.getPhoneNumber();
  var code = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmCodeCubit, ConfirmCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            NoteMessage.showDoneDialog(context, text: S.of(context).done_resend_code);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawableText.header(
                text: S.of(context).numberPhone,
              ),
              DrawableText.header(
                text: S.of(context).confirmation,
              ),
              40.0.verticalSpace,
              DrawableText(text: S.of(context).enterOTP),
              35.0.verticalSpace,
              PinCodeWidget(onCompleted: (p0) => code = p0),
              35.0.verticalSpace,
              DrawableText(
                text: S.of(context).didNotReceiveOTP,
                drawablePadding: 10.0.w,
                drawableEnd: TextButton(
                  onPressed: () {
                    NoteMessage.showDoneDialog(
                      context,
                      text: S.of(context).done_resend_code,
                    );
                    // context.read<ResendCodeCubit>().resendCode(context, phone: phone);
                  },
                  child: BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                    builder: (context, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return DrawableText(
                        text: S.of(context).resend,
                        underLine: true,
                        fontFamily: FontManager.cairoBold,
                      );
                    },
                  ),
                ),
              ),
              90.0.verticalSpace,
              BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                builder: (context, state) {
                  if (state.statuses == CubitStatuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).verify,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.home, (route) => false);
                      // if (code.length < 4) return;
                      // context.read<ConfirmCodeCubit>().confirmCode(
                      //       context,
                      //       phone: phone,
                      //       code: code,
                      //     );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
