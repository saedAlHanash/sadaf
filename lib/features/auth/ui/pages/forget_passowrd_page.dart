import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/forget_password_cubit/forget_password_cubit.dart';

var otp = '';
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final ForgetPasswordCubit forgetPasswordCubit;
  late final ForgetPasswordInitial forgetPasswordState;

  @override
  void initState() {
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
    forgetPasswordState = context.read<ForgetPasswordCubit>().state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        otp= state.result;
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.otpPassword, (route) => false);
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).forgetPassword),
        body: Padding(
          padding: MyStyle.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawableText(
                text: S.of(context).confirmMethod,
                size: 16.0.sp,
                padding: const EdgeInsets.only(left: 30.0).w,
              ),
              30.0.verticalSpace,
              MyTextFormOutLineWidget(
                iconWidget: Padding(
                  padding: const EdgeInsets.all(15.0).r,
                  child: ImageMultiType(
                      url: forgetPasswordState.emailC.text.isEmpty
                          ? Assets.iconsEmptyPoint
                          : Assets.iconsPoint),
                ),
                textDirection: TextDirection.ltr,
                keyBordType: TextInputType.emailAddress,
                controller: forgetPasswordState.emailC,
                label: S.of(context).email,
                onChanged: (val) {
                  setState(() {
                    forgetPasswordState.phoneCallC.clear();
                    forgetPasswordState.phoneSmsC.clear();
                  });
                },
              ),
              MyTextFormOutLineWidget(
                iconWidget: Padding(
                  padding: const EdgeInsets.all(15.0).r,
                  child: ImageMultiType(
                      url: forgetPasswordState.phoneCallC.text.isEmpty
                          ? Assets.iconsEmptyPoint
                          : Assets.iconsPoint),
                ),
                textDirection: TextDirection.ltr,
                keyBordType: TextInputType.phone,
                controller: forgetPasswordState.phoneCallC,
                label: S.of(context).phoneCall,
                onChanged: (val) {
                  setState(() {
                    forgetPasswordState.emailC.clear();
                    forgetPasswordState.phoneSmsC.clear();
                  });
                },
              ),
              MyTextFormOutLineWidget(
                textDirection: TextDirection.ltr,
                keyBordType: TextInputType.phone,
                controller: forgetPasswordState.phoneSmsC,
                iconWidget: Padding(
                  padding: const EdgeInsets.all(15.0).r,
                  child: ImageMultiType(
                      url: forgetPasswordState.phoneSmsC.text.isEmpty
                          ? Assets.iconsEmptyPoint
                          : Assets.iconsPoint),
                ),
                label: S.of(context).phoneSms,
                onChanged: (val) {
                  setState(() {
                    forgetPasswordState.emailC.clear();
                    forgetPasswordState.phoneCallC.clear();
                  });
                },
              ),
              30.0.verticalSpace,
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordInitial>(
                builder: (_, state) {
                  if (state.statuses == CubitStatuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).continueTo,
                    enable: forgetPasswordState.getEmailOrPhone != null,
                    onTap: () {
                      forgetPasswordCubit.forgetPassword();
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
