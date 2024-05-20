import 'dart:typed_data';

import 'package:csa_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class AnimatedCirclerAvatar extends StatelessWidget {
  final Uint8List image;
  const AnimatedCirclerAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      color: ColorsManager.primary,
      delay: const Duration(milliseconds: 200),
      repeat: true,
      minRadius: 13,
      ripplesCount: 4,
      duration: const Duration(milliseconds: 6 * 200),
      child: ClipOval(
        child: SizedBox(
          width: 30, // Adjust the size as needed
          height: 30, // Adjust the size as needed
          child: image.isEmpty
              ? Image.asset(
                  "assets/icons/member-default.png",
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  image,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
