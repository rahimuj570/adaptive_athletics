class LoginResponseModel {
  //  "email": "user@example.com",
  // "type": "RUNNER",
  // "first_name": "string",
  // "last_name": "string",
  // "image": "string",
  // "address1": "string",
  // "phone1": "string"

  final String email;
  final String type;
  final String firstName;
  final String lastName;
  final String? image;
  final String? address1;
  final String? phone1;

  LoginResponseModel({
    required this.email,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.address1,
    required this.phone1,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      email: json['email'],
      type: json['type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      address1: json['address1'],
      phone1: json['phone1'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'type': type,
    'first_name': firstName,
    'last_name': lastName,
    'image': image,
    'address1': address1,
    'phone1': phone1,
  };
}
