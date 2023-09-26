import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';
import '../widget/ask_auth_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  var request = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResendCodeCubit, ResendCodeInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        AppSharedPreference.cashPhoneNumber(request);
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.resetPasswordPage, (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const AskAuthWidget(),
          appBar: const AppBarWidget(titleText: 'هل نسيت كلمة السر؟'),
          body: Padding(
            padding: MyStyle.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: 'لا تقلق! دعنا نساعدك لاستعاده كلمه المرور\nالخاصة بك',
                  padding: const EdgeInsets.only(left: 30.0).w,
                ),
                Container(
                  decoration: MyStyle.roundBox,
                  padding: const EdgeInsets.all(15.0).r,
                  margin: const EdgeInsets.symmetric(vertical: 15.0).h,
                  child: Column(
                    children: [
                      DrawableText(
                        text: 'أرسل إلى هاتفك',
                        size: 20.0.spMin,
                        matchParent: true,
                        fontFamily: FontManager.cairoBold,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                        drawableAlin: DrawableAlin.between,
                        drawableEnd: ImageMultiType(
                          url: Assets.iconsPhone,
                          height: 25.0.r,
                          width: 25.0.r,
                        ),
                      ),
                      10.0.verticalSpace,
                      DrawableText(
                        size: 14.0.spMin,
                        padding: const EdgeInsets.only(left: 30.0).w,
                        text:
                            'سنقوم بإرسال رسالة نصية تحتوي على رمز إعادة تعيين كلمة المرور للرقم الهاتف الخاص بحسابك',
                      ),
                    ],
                  ),
                ),
                30.0.verticalSpace,
                MyTextFormOutLineWidget(
                  textDirection: TextDirection.ltr,
                  keyBordType: TextInputType.phone,
                  initialValue: request,
                  label: S.of(context).phoneNumber,
                  onChanged: (val) => request = val,
                ),
                30.0.verticalSpace,
                BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                  builder: (_, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).continueTo,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteName.resetPasswordPage, (route) => false);
                        // var r = request.checkPhoneNumber(context, request);
                        // if (r == null) return;
                        // request = r;
                        // context
                        //     .read<ResendCodeCubit>()
                        //     .resendCode(context, phone: request);
                      },
                    );
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
