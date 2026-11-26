import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 24,
    this.color = AppColors.surface,
    this.lifted = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;

  /// Hanya kartu fokus yang mengambang; sisanya rata dengan garis tipis.
  final bool lifted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: lifted ? null : Border.all(color: AppColors.line),
        boxShadow: lifted
            ? [
                BoxShadow(
                  color: AppColors.navy.withAlpha(26),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
