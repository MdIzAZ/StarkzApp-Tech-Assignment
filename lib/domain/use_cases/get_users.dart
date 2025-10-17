import '../../data/repositories/user_repository.dart';
import '../entities/user_entity.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<UserEntity>> call() async {
    return await repository.getUsers();
  }
}