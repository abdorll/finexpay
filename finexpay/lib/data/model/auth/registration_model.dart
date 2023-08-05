
class SignUpModel{

  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String? agree;
  final String username;
  final String password;
  final String password_confirmation;
  final String country_code;
  final String country;
  final String mobile_code;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.agree,
    required this.username,
    required this.password,
    required this.password_confirmation,
    required  this.country_code,
    required this.country,
    required this.mobile_code
  });
}