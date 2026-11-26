import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/info_chip.dart';

/// Kontrol yang fiturnya belum dibangun memberi tahu pengguna, bukan diam.
void showComingSoon(BuildContext context, String feature) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$feature segera hadir.')));
}

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const InfoChip(label: 'Segera hadir', icon: Icons.schedule_rounded),
            const SizedBox(height: 16),
            Text(
              title,
              style: appText(22, weight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: appText(14, color: AppColors.textMuted, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
