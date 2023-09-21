import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:sadaf/features/auth/data/request/signup_request.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/strings/app_string_manager.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state)  {
        NoteMessage.showDoneDialog(
          context,
          text: 'تم إنشاء الحساب',
          onCancel: () => Navigator.pushReplacementNamed(context, RouteName.login),
        );
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(titleText: 'إنشاء حساب'),
          bottomNavigationBar: const AskAuthWidget(login: false),
          body: SingleChildScrollView(
            padding: MyStyle.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //الاسم
                MyTextFormOutLineWidget(
                  initialValue: request.name,
                  label: AppStringManager.userName,
                  onChanged: (val) => request.name = val,
                ),
                // رقم الهاتف
                MyTextFormOutLineWidget(
                  textDirection: TextDirection.ltr,
                  keyBordType: TextInputType.phone,
                  initialValue: request.phoneNumber,
                  maxLength: 11,
                  label: AppStringManager.phoneNumber,
                  onChanged: (val) => request.phoneNumber = val,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  label: AppStringManager.password,
                  obscureText: true,
                  onChanged: (val) => request.password = val,
                  textDirection: TextDirection.ltr,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  label: AppStringManager.rePassword,
                  obscureText: true,
                  onChanged: (val) => request.rePassword = val,
                  textDirection: TextDirection.ltr,
                ),

                DrawableText(
                  text: 'توافق علي الشروط والأحكام',
                  drawablePadding: 5.0.w,
                  drawableStart: StatefulBuilder(builder: (context, myState) {
                    return Checkbox(
                        value: request.isAcceptPolicy,
                        onChanged: (value) {
                          myState(() => request.isAcceptPolicy = value);
                        });
                  }),
                  drawableEnd: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.privacy);
                    },
                    child: const DrawableText(
                      text: 'هنا',
                      color: AppColorManager.mainColorLight,
                      underLine: true,
                    ),
                  ),
                  // drawableStart: Checkbox(
                  //   value: true,
                  //   onChanged: (value) {},
                  // ),
                ),
                MyButton(
                  text: AppStringManager.continueSignUp,
                  onTap: () {
                    if (request.validateFirst(context)) {
                      return Navigator.pushNamed(
                        context,
                        RouteName.myAddress,
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

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key, required this.request}) : super(key: key);
  final SignupRequest request;

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.confirmCode, (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(titleText: 'عنواني'),
          body: SingleChildScrollView(
            padding: MyStyle.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: 'يجب عليك ادخال البينات الصحيحة \nلتجنب المشاكل والاخطاء',
                  size: 22.0.spMin,
                ),
                20.0.verticalSpace,
                //عنوان المنزل
                MyTextFormOutLineWidget(
                  initialValue: widget.request.address,
                  label: AppStringManager.homeAddress,
                  onChanged: (val) => widget.request.address = val,
                ),
                // المنطقة
                MyTextFormOutLineWidget(
                  initialValue: widget.request.city,
                  label: AppStringManager.region,
                  onChanged: (val) => widget.request.city = val,
                ),
                // المحافظة
                MyTextFormOutLineWidget(
                  label: AppStringManager.city,
                  initialValue: widget.request.country,
                  onChanged: (val) => widget.request.country = val,
                ),

                BlocBuilder<SignupCubit, SignupInitial>(
                  builder: (context, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: AppStringManager.confirm,
                      onTap: () async {
                        final result = await widget.request.validateSecond(context);

                        if (result && mounted) {
                          context
                              .read<SignupCubit>()
                              .signup(context, request: widget.request);
                        }

                        // context.read<SignupCubit>().signup(context, request: request);
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
