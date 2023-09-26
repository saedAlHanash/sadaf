import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../data/request/reset_password_request.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final request = ResetPasswordRequest();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.login, (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: 1.0.sw,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.iconsBackCover),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26.0).w,
              children: [
                DrawableText(
                  text:
                      '${S.of(context).codeSentToEmail} ${AppSharedPreference.getCashedEmail()}',
                  matchParent: true,
                  textAlign: TextAlign.center,
                ),
                121.0.verticalSpace,
                PinCodeWidget(
                  onChange: (val) => request.code = val,
                ),
                20.0.verticalSpace,
                MyTextFormOutLineWidget(
                  textDirection: TextDirection.ltr,
                  keyBordType: TextInputType.visiblePassword,
                  hint: S.of(context).newPassword,
                  onChanged: (val) => request.password = val,
                ),
                120.verticalSpace,
                BlocBuilder<ResetPasswordCubit, ResetPasswordInitial>(
                  builder: (_, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      width: 244.0.w,
                      text: S.of(context).continueTo,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteName.login, (route) => false);
                        // context
                        //     .read<ResetPasswordCubit>()
                        //     .resetPassword(context, request: request);
                      },
                    );
                  },
                ),
                30.0.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
