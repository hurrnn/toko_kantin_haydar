import 'package:flutter/material.dart';

class MenuImage extends StatelessWidget {
  const MenuImage({
    required this.imagePath,
    this.borderRadius = 18,
    super.key,
  });

  final String imagePath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFFE4EFE6),
          alignment: Alignment.center,
          child: const Icon(
            Icons.restaurant,
            color: Color(0xFF34785A),
            size: 38,
          ),
        ),
      ),
    );
  }
}
