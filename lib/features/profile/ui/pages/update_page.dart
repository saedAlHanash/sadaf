import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/core/widgets/spinner_widget.dart';
import 'package:sadaf/features/profile/bloc/profile_cubit/profile_cubit.dart';
import 'package:sadaf/features/profile/data/response/profile_response.dart';
import 'package:sadaf/features/profile/ui/widget/top_profile_widget.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../governors/bloc/governors_cubit/governors_cubit.dart';
import '../../../map/bloc/my_location_cubit/my_location_cubit.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/request/update_profile_request.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.updateType});

  final UpdateType updateType;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final user = AppProvider.profile;
  late UpdateProfileRequest request;
  late final UpdateProfileCubit updateCubit;

  @override
  void initState() {
    updateCubit = context.read<UpdateProfileCubit>();
    request = updateCubit.state.request;
    request.type = widget.updateType;
    request.avatar = UploadFile(initialImage: user.avatar, nameField: 'avatar');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<ProfileCubit>().getProfile();
          },
        ),
        BlocListener<MyLocationCubit, MyLocationInitial>(
          listenWhen: (p, c) => c.state.done,
          listener: (context, state) {
            updateCubit.setHomeAddress = state.name;
            updateCubit.addressController.text = state.name;
            updateCubit.setMapAddress = MapAddress(
              latitude: state.result.latitude,
              longitude: state.result.longitude,
            );
            updateCubit.locationController.text =
                updateCubit.state.request.mapAddress.toString();
          },
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(
              context,
              message: '',
              onCancel: () {
                Navigator.pop(context);
              },
            );
          },
          builder: (context, state) {
            return Container(
              constraints: BoxConstraints(maxHeight: 120.0.h),
              padding: const EdgeInsets.all(20.0).r,
              child: MyButton(
                text: S.of(context).saveChange,
                child: state.statuses.loading
                    ? MyStyle.loadingWidget(color: Colors.white)
                    : null,
                onTap: () {
                  if (state.statuses.loading) return;
                  updateCubit.updateProfile();
                },
              ),
            );
          },
        ),
        appBar: const AppBarWidget(zeroHeight: true),
        body: SingleChildScrollView(
          child: TopProfileWidget(
            onLoad: (bytes) {
              setState(() {
                updateCubit.setAvatar = request.avatar!.copyWith(fileBytes: bytes);
              });
            },
            file: request.avatar,
            title: widget.updateType.getName,
            children: [
              if (widget.updateType == UpdateType.name)
                MyTextFormOutLineWidget(
                  label: S.of(context).name,
                  onChanged: (val) => updateCubit.setName = val,
                  initialValue: request.name,
                ),
              if (widget.updateType == UpdateType.phone)
                MyTextFormOutLineWidget(
                  label: S.of(context).phoneNumber,
                  onChanged: (val) => updateCubit.setEmailOrPhone = val,
                  initialValue: request.emailOrPhone?.replaceAll('+964', ''),
                ),
              if (widget.updateType == UpdateType.email)
                MyTextFormOutLineWidget(
                  label: S.of(context).email,
                  onChanged: (val) => updateCubit.setEmailOrPhone = val,
                  initialValue: request.emailOrPhone,
                ),
              if (widget.updateType == UpdateType.address)
                Column(
                  children: [
                    BlocBuilder<GovernorsCubit, GovernorsInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return SpinnerWidget(
                          hintText: S.of(context).governor.toUpperCase(),
                          isOverButton: true,
                          expanded: true,
                          items: state.getSpinnerItem(selectedId: user.governor.id),
                          hint: user.governor.id == 0
                              ? DrawableText(
                                  text: S.of(context).selectGovernor,
                                  color: AppColorManager.gray,
                                )
                              : null,
                          onChanged: (item) {
                            updateCubit.setGovernor = item.id;
                          },
                        );
                      },
                    ),
                    15.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      label: S.of(context).yourAddress,
                      onChanged: (val) => updateCubit.setHomeAddress = val,
                      controller: updateCubit.addressController,
                    ),
                    MyTextFormOutLineWidget(
                      label: S.of(context).receiverPhone,
                      hint: '07 * * * * * * * *',
                      helperText: S.of(context).helperPhoneText,
                      onChanged: (val) => updateCubit.setReceiverPhone = val,
                      initialValue: user.receiverPhone.replaceAll('+964', ''),
                    ),
                    MyTextFormOutLineWidget(
                      label: S.of(context).location,
                      controller: updateCubit.locationController,
                      enable: false,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            color: AppColorManager.mainColorLight,
                            text: S.of(context).selectFromMap,
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.map,
                                      arguments: user.mapAddress.getLatLng)
                                  .then((value) {
                                if (value != null && value is LatLng) {
                                  getLocationNameApi(latLng: value).then((locationName) {
                                    updateCubit.setHomeAddress = locationName;
                                    updateCubit.addressController.text = locationName;
                                  });

                                  updateCubit.setMapAddress = MapAddress(
                                    latitude: value.latitude,
                                    longitude: value.longitude,
                                  );
                                  updateCubit.locationController.text =
                                      updateCubit.state.request.mapAddress.toString();
                                }
                              });
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: BlocBuilder<MyLocationCubit, MyLocationInitial>(
                            builder: (context, state) {
                              if (state.state.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return MyButton(
                                color: AppColorManager.mainColorLight,
                                text: S.of(context).myLocation,
                                onTap: () {
                                  context.read<MyLocationCubit>().getMyLocation(context);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    50.0.verticalSpace,
                  ],
                ),
              if (widget.updateType == UpdateType.pass)
                Column(
                  children: [
                    MyTextFormOutLineWidget(
                      label: S.of(context).currentPassword,
                      onChanged: (val) => request.oldPass = val,
                    ),
                    MyTextFormOutLineWidget(
                      obscureText: true,
                      label: S.of(context).newPassword,
                      onChanged: (val) => request.newPass = val,
                    ),
                    MyTextFormOutLineWidget(
                      obscureText: true,
                      label: S.of(context).confirmNewPassword,
                      onChanged: (val) => request.rePass = val,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
