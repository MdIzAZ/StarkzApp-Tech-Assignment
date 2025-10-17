import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'clear') {
                      context.read<ProfileBloc>().add(ClearFilter());
                    } else {
                      context.read<ProfileBloc>().add(FilterByCountry(value));
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    final items = state.countries.map((country) {
                      return PopupMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList();

                    items.add(
                      const PopupMenuItem<String>(
                        value: 'clear',
                        child: Text('Clear Filter', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    );
                    return items;
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProfileBloc>().add(FetchUsers());
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                return Column(
                  children: [
                    if (state.activeFilter != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text('Filtering by: ${state.activeFilter}'),
                          onDeleted: () {
                            context.read<ProfileBloc>().add(ClearFilter());
                          },
                        ),
                      ),
                    Expanded(

                      child: Container(
                        color: Colors.white, // ✅ White background for grid section
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: state.filteredUsers.length,
                          itemBuilder: (context, index) {
                            return UserCard(user: state.filteredUsers[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProfileBloc>().add(FetchUsers()),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Welcome!'));
            },
          ),
        ),
      ),
    );
  }
}

