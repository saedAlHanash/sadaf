import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_string_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/auth/ui/widget/ask_auth_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(titleText: 'تسجيل الدخول'),
          bottomNavigationBar: const AskAuthWidget(login: true),
          body: Container(
            width: 1.0.sw,
            height: 1.0.sh,
            padding: MyStyle.authPagesPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  140.verticalSpace,
                  MyTextFormOutLineWidget(
                    textDirection: TextDirection.ltr,
                    keyBordType: TextInputType.phone,
                    initialValue: request.phone,
                    label: AppStringManager.phoneNumber,
                    onChanged: (val) => request.phone = val,
                  ),
                  20.0.verticalSpace,
                  MyTextFormOutLineWidget(
                    label: AppStringManager.password,
                    obscureText: true,
                    onChanged: (val) => request.password = val,
                    textDirection: TextDirection.ltr,
                  ),
                  30.0.verticalSpace,
                  BlocBuilder<LoginCubit, LoginInitial>(
                    builder: (_, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      //تسجيل الدخول
                      return MyButton(
                        text: AppStringManager.login,
                        onTap: () {
                          var r = request.phone.checkPhoneNumber(context, request.phone);
                          if (r == null) return;
                          request.phone = r;
                          context.read<LoginCubit>().login(context, request: request);
                        },
                      );
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.forgetPassword);
                      },
                      child: const DrawableText(
                        text: AppStringManager.forgetPassword,
                        underLine: true,
                        matchParent: true,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
