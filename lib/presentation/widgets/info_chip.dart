import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.label,
    this.icon,
    this.dotColor,
    this.background = AppColors.tint,
    this.foreground = AppColors.navy,
    this.size = 12,
  });

  final String label;
  final IconData? icon;
  final Color? dotColor;
  final Color background;
  final Color foreground;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (icon != null) ...[
            Icon(icon, size: size + 3, color: foreground),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: appText(size, weight: FontWeight.w700, color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
