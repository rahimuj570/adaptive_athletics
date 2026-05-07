// {
//   "first_name": "string",
//   "last_name": "string",
//   "email": "user@example.com",
//   "password": "string",
//   "confirm_password": "string"
// }

class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirm_password'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
    'confirm_password': confirmPassword,
  };
}
