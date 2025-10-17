import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.pictureLarge,
    required super.age,
    required super.city,
    required super.country,
    super.isLiked,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['login']['uuid'],
      firstName: json['name']['first'],
      pictureLarge: json['picture']['large'],
      age: json['dob']['age'],
      city: json['location']['city'],
      country: json['location']['country'],
    );
  }

  UserModel copyWith({bool? isLiked}) {
    return UserModel(
      id: id,
      firstName: firstName,
      pictureLarge: pictureLarge,
      age: age,
      city: city,
      country: country,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}