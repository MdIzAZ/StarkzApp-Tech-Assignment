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
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),

          // ⚪ Bottom white detail section
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // White section with inward curved notch
                ClipPath(
                  clipper: TopNotchClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                  final currentUser = state.users.firstWhere(
                                    (u) => u.id == user.id,
                                  );
                                  isLiked = currentUser.isLiked;
                                }
                                return AnimatedHeartIcon(
                                  isLiked: isLiked,
                                  onTap:
                                      () => context.read<ProfileBloc>().add(
                                        ToggleLike(user.id),
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Location',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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

                // Floating handle bar INSIDE the notch
                Positioned(
                  top: -4,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

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

class TopNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const cornerRadius = 24.0;
    const notchWidth = 80.0;
    const notchDepth = 8.0;

    // Start from the top left, after the corner radius.
    path.moveTo(cornerRadius, 0);

    // Draw the line to the notch's left side
    final halfWidth = size.width / 2;
    path.lineTo(halfWidth - notchWidth / 2, 0);

    // --- Rectangular Notch Logic ---
    // Draw down to create the left side of the notch
    path.lineTo(halfWidth - notchWidth / 2 + 10, notchDepth);
    // Draw across to create the bottom of the notch
    path.lineTo(halfWidth + notchWidth / 2 - 10, notchDepth);
    // Draw up to create the right side of the notch
    path.lineTo(halfWidth + notchWidth / 2, 0);

    // Draw the line from the notch to the top right corner
    path.lineTo(size.width - cornerRadius, 0);

    // Draw the top right corner
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Draw the right side
    path.lineTo(size.width, size.height);

    // Draw the bottom side
    path.lineTo(0, size.height);

    // Draw the left side
    path.lineTo(0, cornerRadius);

    // Draw the top left corner
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
