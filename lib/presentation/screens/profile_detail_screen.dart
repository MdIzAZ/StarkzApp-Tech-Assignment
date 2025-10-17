import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/animated_heart_icon.dart';

class ProfileDetailScreen extends StatelessWidget {
  final UserEntity user;

  const ProfileDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'profile_picture_${user.id}',
                child: CachedNetworkImage(
                  imageUrl: user.pictureLarge,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${user.firstName}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          bool isLiked = false;
                          if (state is ProfileLoaded) {
                            final currentUser = state.users.firstWhere((u) => u.id == user.id);
                            isLiked = currentUser.isLiked;
                          }
                          return AnimatedHeartIcon(
                            isLiked: isLiked,
                            onTap: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(ToggleLike(user.id));
                            },
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.city}, ${user.country}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );*/
    /*return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'profile_picture_${user.id}',
              child: CachedNetworkImage(
                imageUrl: user.pictureLarge,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${user.firstName}, ${user.age}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        bool isLiked = false;
                        if (state is ProfileLoaded) {
                          final currentUser =
                          state.users.firstWhere((u) => u.id == user.id);
                          isLiked = currentUser.isLiked;
                        }
                        return AnimatedHeartIcon(
                          isLiked: isLiked,
                          onTap: () {
                            context
                                .read<ProfileBloc>()
                                .add(ToggleLike(user.id));
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${user.city}, ${user.country}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image (fills everything)
          Positioned.fill(
            child: Hero(
              tag: 'profile_picture_${user.id}',
              child: CachedNetworkImage(
                imageUrl: user.pictureLarge,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
          ),

          // ⚪ Bottom white detail section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // only take needed height
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${user.firstName}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          bool isLiked = false;
                          if (state is ProfileLoaded) {
                            final currentUser = state.users
                                .firstWhere((u) => u.id == user.id);
                            isLiked = currentUser.isLiked;
                          }
                          return AnimatedHeartIcon(
                            isLiked: isLiked,
                            onTap: () => context
                                .read<ProfileBloc>()
                                .add(ToggleLike(user.id)),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.city}, ${user.country}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Top "AppBar-like" icons floating over image
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ⬅️ Back icon
                  _TopIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),

                  // ⋮ More icon
                  _TopIconButton(
                    icon: Icons.more_vert,
                    onTap: () {
                      // handle tap
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}


class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4), // semi-transparent bg
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}