import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String image;

  const Background({
    super.key,
    required this.child,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image Layer
        Positioned.fill(
          child: Image.asset(
            image,
            // BoxFit.cover ensures the image fills the entire screen
            // while maintaining aspect ratio (cropping if necessary)
            fit: BoxFit.cover,
            // Adding alignment center to ensure the focus remains in the middle
            alignment: Alignment.center,
          ),
        ),

        // Content Layer
        // We use a SizedBox.expand to ensure the child can take up the full screen
        SizedBox.expand(
          child: child,
        ),
      ],
    );
  }
}