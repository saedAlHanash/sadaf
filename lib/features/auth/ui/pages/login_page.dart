import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../bloc/login_social_cubit/login_social_cubit.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit loginCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
        BlocListener<LoginSocialCubit, LoginSocialInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DrawableText(
                  text: S.of(context).welcomeBack,
                  size: 28.0.spMin,
                  fontFamily: FontManager.cairoBold.name,
                  matchParent: true,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: S.of(context).signInToContinue,
                  size: 14.0.spMin,
                  matchParent: true,
                ),
                30.0.verticalSpace,
                MyTextFormOutLineWidget(
                  validator: (p0) => loginCubit.validatePhoneOrEmail,
                  label: S.of(context).phoneNumber,
                  initialValue: loginCubit.state.request.phoneOrEmail,
                  //TODO: change this to phone
                  keyBordType: TextInputType.emailAddress,
                  onChanged: (val) => loginCubit.setPhoneOrEmail = val,
                ),
                15.0.verticalSpace,
                MyTextFormOutLineWidget(
                  validator: (p0) => loginCubit.validatePassword,
                  label: S.of(context).password,
                  initialValue: loginCubit.state.request.password,
                  onChanged: (val) => loginCubit.setPassword = val,
                ),
                const _ForgetAndRememberWidget(),
                20.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).login,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        loginCubit.login();
                      },
                    );
                  },
                ),
                18.0.verticalSpace,
                DrawableText(
                  text: S.of(context).doNotHaveAnAccount,
                  drawableAlin: DrawableAlin.between,
                  matchParent: true,
                  drawableEnd: TextButton(
                    onPressed: () => Navigator.pushNamed(context, RouteName.signup),
                    child: DrawableText(
                      fontFamily: FontManager.cairoBold.name,
                      text: '${S.of(context).signUp}.',
                    ),
                  ),
                ),
                40.0.verticalSpace,
                DrawableText(
                  matchParent: true,
                  text: S.of(context).signInWithSocialNetworks,
                ),
                20.0.verticalSpace,
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await FacebookAuth.instance.logOut();
                        final result = await FacebookAuth.instance.login();

                        if (result.status == LoginStatus.success) {
                          // you are logged
                          final accessToken = result.accessToken!;

                        } else {
                          print(result.status);
                          print(result.message);
                        }
                      },
                      child: ImageMultiType(
                        url: Assets.iconsFbLogin,
                        width: 60.0.r,
                        height: 30.0.r,
                      ),
                    ),
                    30.0.horizontalSpace,
                    InkWell(
                      onTap: () {
                        context.read<LoginSocialCubit>().loginGoogle();
                      },
                      child: BlocBuilder<LoginSocialCubit, LoginSocialInitial>(
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return ImageMultiType(
                            url: Assets.iconsGLogin,
                            width: 60.0.r,
                            height: 30.0.r,
                          );
                        },
                      ),
                    ),
                  ],
                ),
               40.0.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawableText(
          text: S.of(context).rememberMe,
          drawableEnd: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.forgetPassword);
          },
          child: DrawableText(
            text: S.of(context).forgetPassword,
            underLine: true,
          ),
        ),
      ],
    );
  }
}
