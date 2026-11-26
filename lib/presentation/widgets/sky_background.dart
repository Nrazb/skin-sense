import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';

/// Gradasi biru langit ke putih: satu-satunya latar halaman, dipakai di semua layar.
class SkyBackground extends StatelessWidget {
  const SkyBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.skyTop, Colors.white],
          stops: [0, 0.45],
        ),
      ),
      child: child,
    );
  }
}
