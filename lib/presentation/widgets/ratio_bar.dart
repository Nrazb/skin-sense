import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';

class RatioBar extends StatelessWidget {
  const RatioBar({
    super.key,
    required this.value,
    required this.label,
    this.color = AppColors.accentBright,
    this.height = 8,
  });

  final double value;
  final String label;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value.clamp(0, 1),
        minHeight: height,
        backgroundColor: AppColors.track,
        valueColor: AlwaysStoppedAnimation(color),
        semanticsLabel: label,
        semanticsValue: '${(value * 100).round()} persen',
      ),
    );
  }
}
