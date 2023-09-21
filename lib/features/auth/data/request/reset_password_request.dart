class ResetPasswordRequest {
  String email;

  String code;

  String password;

  ResetPasswordRequest({
    this.email = '',
    this.code = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': code,
      'password': password,
    };
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> map) {
    return ResetPasswordRequest(
      email: map['email'] ?? '',
      code: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
