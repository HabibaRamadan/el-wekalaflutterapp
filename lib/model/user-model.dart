
class UserModel {
  User? user;
  String? status;
  String? message;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? name;
  String? email;
  String? password;
  String? nationalId;
  String? gender;
  String? phone;
  String? image;
  String? token;

  User(
      {required this.email,
      required this.password,
      required this.phone,
      required this.name,
      required this.gender,
      required this.nationalId,
      this.image,
      this.token = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      name: json['name'],
      gender: json['gender'],
      nationalId: json['nationalId'],
      image: json['profileImage'],
      token: json['token']
    );
  }

  Map<String, dynamic> toJson(image) {
    return {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "gender": "male",
      "nationalId": nationalId,
      "profileImage": image,
    };
  }
}
