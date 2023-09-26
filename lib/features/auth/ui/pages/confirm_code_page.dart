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
            NoteMessage.showDoneDialog(context, text: 'تم إعادة الإرسال');
          },
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(titleText: 'تحقق من هاتفك'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0).r,
              child: Column(
                children: [
                  Container(
                    decoration: MyStyle.outlineBorder,
                    padding: const EdgeInsets.all(20.0).r,
                    child: Column(
                      children: [
                        DrawableText(
                          text: 'تم ارسال رمز التأكيد الخاص بك  الى رقم $phone',
                          size: 16.0.spMin,
                          textAlign: TextAlign.start,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: 'يرجى ادخال الرمز في الاسفل',
                          size: 16.0.spMin,
                          textAlign: TextAlign.start,
                          matchParent: true,
                        ),
                      ],
                    ),
                  ),
                  40.0.verticalSpace,
                  PinCodeWidget(
                    onCompleted: (p0) => code = p0,
                  ),
                  90.0.verticalSpace,
                  BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                    builder: (context, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        text: 'تحقق',
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
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
                  50.0.verticalSpace,
                  TextButton(
                    onPressed: () {
                      NoteMessage.showDoneDialog(context, text: 'تم إعادة الإرسال');
                      // context.read<ResendCodeCubit>().resendCode(context, phone: phone);
                    },
                    child: BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                      builder: (context, state) {
                        if (state.statuses == CubitStatuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return DrawableText(
                          text: 'أعد إرسال الرمز',
                          textAlign: TextAlign.center,
                          size: 20.0.spMin,
                          color: AppColorManager.mainColorDark,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
