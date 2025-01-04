import 'package:go_healing/features/user/domain/entities/user.dart';

class UserModel extends User {
  final String firstName;
  final String lastName;
  final String avatar;

  const UserModel({
    required super.id,
    required super.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
          fullName: '$firstName $lastName',
          profileImageUrl: avatar,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  static List<UserModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => UserModel.fromJson(e)).toList();
  }
}
