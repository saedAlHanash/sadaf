

class SignupRequest {
  SignupRequest({
    this.name ,
    this.birthday,
    this.phoneOrEmail ,
    this.password ,
  });

  String? name;
  DateTime? birthday;
  String? phoneOrEmail;
  String? password;
  String? rePassword;


  //--------
  bool? isAcceptPolicy = false;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": phoneOrEmail,
        "dob": birthday?.toIso8601String(),
        "password": password,

      };

}
