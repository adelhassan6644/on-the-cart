class VerificationModel {
  String email;
  String? code;
  bool fromRegister;
  VerificationModel(this.email, {this.code, this.fromRegister = true});
  bool isEmpty() => email == "";

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}
