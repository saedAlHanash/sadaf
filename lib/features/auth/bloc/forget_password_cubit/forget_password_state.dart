part of 'forget_password_cubit.dart';

class ForgetPasswordInitial extends AbstractCubit {
  final TextEditingController emailC  ;
  final TextEditingController phoneCallC  ;
  final TextEditingController phoneSmsC  ;

  String? get getEmailOrPhone {

    if (emailC.text.isNotEmpty) return checkEmail(emailC.text);
    if (phoneCallC.text.isNotEmpty) return phoneCallC.text;
    if (phoneSmsC.text.isNotEmpty) return phoneSmsC.text;
    return null;
  }

  const ForgetPasswordInitial({
    required this.emailC,
    required this.phoneCallC,
    required this.phoneSmsC,
    required super.result,
    super.error,
    super.statuses,
  });

  factory ForgetPasswordInitial.initial() {
    return ForgetPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
        emailC:TextEditingController(),
        phoneCallC:TextEditingController(),
        phoneSmsC:TextEditingController(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ForgetPasswordInitial copyWith({
    TextEditingController? emailC,
    TextEditingController? phoneCallC,
    TextEditingController? phoneSmsC,
    CubitStatuses? statuses,
    dynamic result,
    String? error,

  }) {
    return ForgetPasswordInitial(
      emailC: emailC ?? this.emailC,
      phoneCallC: phoneCallC ?? this.phoneCallC,
      phoneSmsC: phoneSmsC ?? this.phoneSmsC,
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,

    );
  }
}
