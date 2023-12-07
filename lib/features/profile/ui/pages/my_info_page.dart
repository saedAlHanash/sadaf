import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/my_button.dart';

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
                    if (!state.result.emailOrPhone.contains('@'))
                      MyTextFormOutLineWidget(
                        enable: false,
                        label: S.of(context).phoneNumber,
                        initialValue: state.result.emailOrPhone,
                        icon: Assets.iconsYourPhone,
                      ),
                    if (state.result.emailOrPhone.contains('@'))
                      MyTextFormOutLineWidget(
                        enable: false,
                        label: S.of(context).yourEmail,
                        initialValue: state.result.emailOrPhone,
                        icon: Assets.iconsEmail,
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
                Navigator.pushNamed(context, RouteName.updateChoice);
              },
            ),
          ],
        ),
      ),
    );
  }
}
