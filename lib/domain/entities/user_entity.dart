import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String pictureLarge;
  final int age;
  final String city;
  final String country;
  final bool isLiked;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.pictureLarge,
    required this.age,
    required this.city,
    required this.country,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [id, firstName, pictureLarge, age, city, country, isLiked];

  UserEntity copyWith({
    bool? isLiked,
  }) {
    return UserEntity(
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