import 'package:dio/dio.dart';
import 'package:starkzapp_tech_assignment/data/repositories/user_repository.dart';
import '../../core/constants.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;

  UserRepositoryImpl(this.dio);

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final response = await dio.get(AppConstants.apiUrl);
      final List<dynamic> results = response.data['results'];
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }
}