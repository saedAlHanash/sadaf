import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/core/widgets/select_date.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final SignupCubit signupCubit;
  late final SignupInitial signupState;
  final _formKey = GlobalKey<FormState>();

  final bDateController = TextEditingController();

  @override
  void initState() {
    signupCubit = context.read<SignupCubit>();
    signupState = signupCubit.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.confirmCode, (route) => false);
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                19.verticalSpace,
                DrawableText.header(text: S.of(context).signUp),
                30.verticalSpace,

                MyTextFormOutLineWidget(
                  validator: (p0) => signupCubit.validateName,
                  initialValue: signupState.request.name,
                  label: S.of(context).name,
                  onChanged: (val) => signupCubit.setName = val,
                ),

                MyTextFormOutLineWidget(
                  validator: (p0) => signupCubit.validateBirthday,
                  controller: bDateController,
                  enable: false,
                  label: S.of(context).birthday,
                  onTap: () async {
                    final datePicked = await showDatePicker(
                        context: context,
                        initialDate: signupState.request.birthday ?? DateTime(2000),
                        lastDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        initialDatePickerMode: DatePickerMode.year,
                        initialEntryMode: DatePickerEntryMode.calendarOnly);
                    if (datePicked == null) return;
                    signupCubit.setBirthday = datePicked;
                    bDateController.text = datePicked.formatDate;
                  },
                  iconWidget: SelectSingeDateScrollWidget(
                    initial: signupState.request.birthday,
                    maxDate: DateTime.now(),
                    minDate: DateTime(1900),
                    onSelect: (selected) {
                      signupCubit.setBirthday = selected;
                      bDateController.text = selected?.formatDate ?? '';
                    },
                  ),
                ),
                // رقم الهاتف
                MyTextFormOutLineWidget(
                  validator: (p0) => signupCubit.validatePhoneOrEmail,
                  initialValue: signupState.request.phoneOrEmail,
                  //TODO: change this to phone
                  keyBordType: TextInputType.emailAddress,
                  label: S.of(context).phoneNumber,
                  onChanged: (val) => signupCubit.setPhoneOrEmail = val,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  validator: (p0) => signupCubit.validatePassword,
                  label: S.of(context).password,
                  obscureText: true,
                  onChanged: (val) => signupCubit.setPassword = val,
                  textDirection: TextDirection.ltr,
                ),
                // كلمة السر
                MyTextFormOutLineWidget(
                  validator: (p0) => signupCubit.validateRePassword,
                  label: S.of(context).rePassword,
                  obscureText: true,
                  onChanged: (val) => signupCubit.setRePassword = val,
                  textDirection: TextDirection.ltr,
                ),

                BlocBuilder<SignupCubit, SignupInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).signUp,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        signupCubit.signup();
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
