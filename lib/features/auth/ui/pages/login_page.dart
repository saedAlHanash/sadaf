import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_checkbox_widget.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/auth/ui/widget/ask_auth_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../data/request/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final request = LoginRequest();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Container(
          width: 1.0.sw,
          height: 1.0.sh,
          padding: MyStyle.authPagesPadding,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  19.verticalSpace,
                  DrawableText(
                    text: S.of(context).welcomeBack,
                    size: 28.0.spMin,
                    fontFamily: FontManager.cairoBold,
                    matchParent: true,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: S.of(context).signInToContinue,
                    size: 14.0.spMin,
                    matchParent: true,
                  ),
                  70.0.verticalSpace,
                  MyTextFormOutLineWidget(
                    validator: (p0) {
                      if (request.phone.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    label: S.of(context).phoneNumber,
                    initialValue: request.phone,
                    keyBordType: TextInputType.phone,
                    onChanged: (val) => request.phone = val,
                  ),
                  20.0.verticalSpace,
                  MyTextFormOutLineWidget(
                    validator: (p0) {
                      if (request.password.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    label: S.of(context).password,
                    obscureText: true,
                    initialValue: request.password,
                    onChanged: (val) => request.password = val,
                  ),
                  _ForgetAndRememberWidget(request: request),
                  30.0.verticalSpace,
                  BlocBuilder<LoginCubit, LoginInitial>(
                    builder: (_, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        text: S.of(context).login,
                        onTap: () {
                          _formKey.currentState!.validate();
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, RouteName.home, (route) => false);
                          // var r = request.phone.checkPhoneNumber(context, request.phone);
                          // if (r == null) return;
                          // request.phone = r;
                          // context.read<LoginCubit>().login(context, request: request);
                        },
                      );
                    },
                  ),
                  DrawableText(
                    text: S.of(context).doNotHaveAnAccount,
                    drawableEnd: TextButton(
                      onPressed: () => Navigator.pushNamed(context, RouteName.signup),
                      child: DrawableText(text: S.of(context).signUp),
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

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget({required this.request});

  final LoginRequest request;

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.forgetPassword);
          },
          child: DrawableText(
            text: S.of(context).forgetPassword,
            underLine: true,
          ),
        ),
        DrawableText(
          text: S.of(context).rememberMe,
          drawableEnd: Checkbox(
            value: widget.request.rememberMe,
            onChanged: (value) {
              setState(() => widget.request.rememberMe = !widget.request.rememberMe);
            },
          ),
        )
      ],
    );
  }
}
