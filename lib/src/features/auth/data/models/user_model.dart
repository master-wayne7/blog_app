import 'package:blog_app/src/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? "",
        email: json['email'] ?? "",
        name: json['name'] ?? "",
      );

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        name: name,
      );
}
