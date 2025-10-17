import 'package:flutter/material.dart';

class AnimatedHeartIcon extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const AnimatedHeartIcon({
    Key? key,
    required this.isLiked,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedHeartIconState createState() => _AnimatedHeartIconState();
}

class _AnimatedHeartIconState extends State<AnimatedHeartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_controller);

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedHeartIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLiked != oldWidget.isLiked) {
      if (widget.isLiked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLiked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: 24,
            ),
          );
        },
      ),
    );
  }
}