import 'dart:io';

import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/images/image_multi_type.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/profile/data/request/update_profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../generated/assets.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pick_image_helper.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AppSharedPreference.getUserModel();

  late UpdateProfileRequest request;

  @override
  void initState() {
    request = UpdateProfileRequest(name: user.name, mobile: user.phone);
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
                            hint: AppStringManager.fullName,
                            color: AppColorManager.black,
                            initialValue: user.name,
                            onChanged: (val) => request.name = val,
                          ),
                          MyTextFormOutLineWidget(
                            hint: AppStringManager.email,
                            color: AppColorManager.black,
                            initialValue: user.city,
                            keyBordType: TextInputType.emailAddress,
                            onChanged: (val) => request.email = val,
                          ),
                          MyTextFormOutLineWidget(
                            hint: AppStringManager.phoneNumber,
                            color: AppColorManager.black,
                            keyBordType: TextInputType.phone,
                            maxLength: 11,
                            initialValue: user.phone,
                            onChanged: (val) => request.mobile = val,
                          ),
                          BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
                            builder: (context, state) {
                              if (state.statuses == CubitStatuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return MyButton(
                                text: 'حفظ المعلومات',
                                width: 0.7.sw,
                                onTap: () {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .updateProfile(context, request: request);
                                },
                              );
                            },
                          ),
                          40.0.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60.0.h,
                    left: 130.0.w,
                    right: 130.0.w,
                    height: 140.0.spMin,
                    child: InkWell(
                      onTap: () async {
                        final image = await PickImageHelper().pickImage();
                        if (context.mounted) {
                          request.path = image?.path;
                          context.read<UpdateProfileCubit>().setImage(image?.path);
                        }
                      },
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
