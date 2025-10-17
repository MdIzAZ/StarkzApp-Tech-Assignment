import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starkzapp_tech_assignment/presentation/bloc/profile_bloc.dart';
import 'package:starkzapp_tech_assignment/presentation/bloc/profile_event.dart';
import 'package:starkzapp_tech_assignment/presentation/screens/home_screen.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/use_cases/get_users.dart';

void main() {

  final dio = Dio();
  final userRepository = UserRepositoryImpl(dio);
  final getUsers = GetUsers(userRepository);

  runApp(MyApp(getUsers: getUsers));
}

class MyApp extends StatelessWidget {
  final GetUsers getUsers;

  const MyApp({super.key, required this.getUsers});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ProfileBloc(getUsers)..add(FetchUsers()),
        child: const HomeScreen(),
      ),
    );
  }
}
