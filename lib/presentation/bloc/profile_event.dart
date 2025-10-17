

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends ProfileEvent {}

class ToggleLike extends ProfileEvent {
  final String userId;

  const ToggleLike(this.userId);

  @override
  List<Object> get props => [userId];
}

class FilterByCountry extends ProfileEvent {
  final String country;

  const FilterByCountry(this.country);

  @override
  List<Object> get props => [country];
}

class ClearFilter extends ProfileEvent {}