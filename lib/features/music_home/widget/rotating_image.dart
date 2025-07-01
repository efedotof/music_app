import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RotatingImage extends StatefulWidget {
  final String imageUrl;
  final bool rotating;

  const RotatingImage({
    super.key,
    required this.imageUrl,
    required this.rotating,
  });

  @override
  State<RotatingImage> createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    if (widget.rotating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.rotating && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.rotating && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
