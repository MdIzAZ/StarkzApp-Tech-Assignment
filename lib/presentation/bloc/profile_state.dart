import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<UserEntity> users;
  final List<UserEntity> filteredUsers;
  final Set<String> countries;
  final String? activeFilter;

  const ProfileLoaded({
    required this.users,
    required this.filteredUsers,
    required this.countries,
    this.activeFilter,
  });

  @override
  List<Object> get props => [users, filteredUsers, countries, activeFilter ?? ''];

  ProfileLoaded copyWith({
    List<UserEntity>? users,
    List<UserEntity>? filteredUsers,
    Set<String>? countries,
    String? activeFilter,
  }) {
    return ProfileLoaded(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      countries: countries ?? this.countries,
      activeFilter: activeFilter,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
