import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';
import '../widget/top_profile_widget.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: SingleChildScrollView(
        child: TopProfileWidget(
          updateImage: false,
          title: S.of(context).profile,
          children: [
            BlocBuilder<ProfileCubit, ProfileInitial>(
              builder: (context, state) {
                return Column(
                  children: [
                    MyTextFormOutLineWidget(
                      enable: false,
                      label: S.of(context).userName,
                      icon: Assets.iconsUserName,
                      initialValue: state.result.name,
                    ),
                    MyTextFormOutLineWidget(
                      enable: false,
                      label: S.of(context).phoneNumber,
                      initialValue: state.result.emailOrPhone,
                      icon: Assets.iconsYourPhone,
                      iconWidgetLift: state.result.showWarning
                          ? const ImageMultiType(
                              url: Icons.warning_amber,
                              color: Colors.amber,
                            )
                          : null,
                    ),
                    MyTextFormOutLineWidget(
                      enable: false,
                      label: S.of(context).yourAddress,
                      icon: Assets.iconsLocator,
                      initialValue: state.result.address,
                    ),
                  ],
                );
              },
            ),
            MyButton(
              text: S.of(context).update,
              onTap: () {
                if (AppProvider.profile.showWarning) {
                  Navigator.pushNamed(
                    context,
                    RouteName.update,
                    arguments: UpdateType.phone,
                  );
                  return;
                }
                Navigator.pushNamed(context, RouteName.updateChoice);
              },
            ),
          ],
        ),
      ),
    );
  }
}
