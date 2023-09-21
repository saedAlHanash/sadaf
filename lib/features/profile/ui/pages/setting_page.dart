import 'dart:io';

import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/images/image_multi_type.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:sadaf/features/profile/data/request/update_profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = AppSharedPreference.getUserModel();

  late UpdateProfileRequest request;

  bool status = false;

  @override
  void initState() {
    request =
        UpdateProfileRequest(name: user.name, mobile: user.phone, email: user.phone);
    status = AppSharedPreference.getActiveNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) => Navigator.pop(context),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: 1.0.sh,
              width: 1.0.sw,
              child: Stack(
                children: [
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                          color: AppColorManager.whit,
                        )),
                  ),
                  Positioned(
                    height: 1.0.sh,
                    width: 1.0.sw,
                    bottom: 0.0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 140.0).h,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                      decoration: BoxDecoration(
                        color: AppColorManager.whit,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0.r)),
                      ),
                      child: Column(
                        children: [
                          70.0.verticalSpace,
                          MyTextFormOutLineWidget(
                            enable: false,
                            hint: AppStringManager.fullName,
                            color: AppColorManager.black,
                            initialValue: user.name,
                            onChanged: (val) => request.name = val,
                          ),
                          MyTextFormOutLineWidget(
                            enable: false,
                            hint: AppStringManager.email,
                            color: AppColorManager.black,
                            initialValue: user.phone,
                            keyBordType: TextInputType.emailAddress,
                            onChanged: (val) => request.email = val,
                          ),
                          MyTextFormOutLineWidget(
                            enable: false,
                            hint: AppStringManager.phoneNumber,
                            color: AppColorManager.black,
                            keyBordType: TextInputType.phone,
                            initialValue: user.phone,
                            onChanged: (val) => request.mobile = val,
                          ),
                          40.0.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 5.0).w,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FlutterSwitch(
                                    activeText: "مفعل",
                                    inactiveText: "متوقف",
                                    value: status,
                                    valueFontSize: 14.0.spMin,
                                    borderRadius: 30.0,
                                    showOnOff: true,
                                    activeColor: AppColorManager.mainColor,
                                    onToggle: (val) {
                                      setState(() {
                                        status = val;
                                        AppSharedPreference.cashActiveNotification(val);
                                      });
                                    },
                                  ),
                                  const DrawableText(
                                    text: 'الإشعارات',
                                    color: AppColorManager.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60.0.h,
                    left: 130.0.w,
                    right: 130.0.w,
                    height: 140.0.spMin,
                    child: BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
                      builder: (context, state) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColorManager.whit,
                              boxShadow: MyStyle.lightShadow),
                          child: ImageMultiType(
                            url: state.image,
                            height: 1.0.sh,
                            width: 1.0.sw,
                            fit: BoxFit.cover,
                          ),
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
