import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starkzapp_tech_assignment/presentation/bloc/profile_event.dart';
import 'package:starkzapp_tech_assignment/presentation/bloc/profile_state.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/get_users.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUsers getUsers;
  List<UserEntity> _masterUserList = [];

  ProfileBloc(this.getUsers) : super(ProfileInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<ToggleLike>(_onToggleLike);
    on<FilterByCountry>(_onFilterByCountry);
    on<ClearFilter>(_onClearFilter);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      _masterUserList = await getUsers();
      final countries = _masterUserList.map((user) => user.country).toSet();
      emit(ProfileLoaded(
        users: _masterUserList,
        filteredUsers: _masterUserList,
        countries: countries,
        activeFilter: null,
      ));
    } catch (e) {
      emit(const ProfileError('Failed to fetch profiles. Please try again.'));
    }
  }

  void _onToggleLike(ToggleLike event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;

      final updatedMasterList = _masterUserList.map((user) {
        if (user.id == event.userId) {
          return user.copyWith(isLiked: !user.isLiked);
        }
        return user;
      }).toList();

      _masterUserList = updatedMasterList;

      final updatedFilteredList = currentState.filteredUsers.map((user) {
        if (user.id == event.userId) {
          return user.copyWith(isLiked: !user.isLiked);
        }
        return user;
      }).toList();

      emit(currentState.copyWith(
        users: updatedMasterList,
        filteredUsers: updatedFilteredList,
      ));
    }
  }

  void _onFilterByCountry(FilterByCountry event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final filteredList = _masterUserList
          .where((user) => user.country == event.country)
          .toList();
      emit(currentState.copyWith(
        filteredUsers: filteredList,
        activeFilter: event.country,
      ));
    }
  }

  void _onClearFilter(ClearFilter event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(
        filteredUsers: _masterUserList,
        activeFilter: null,
      ));
    }
  }
}
