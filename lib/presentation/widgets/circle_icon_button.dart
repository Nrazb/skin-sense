import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.dark = false,
    this.size = 48,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool dark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      tooltip: label,
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      style: IconButton.styleFrom(
        backgroundColor: dark ? AppColors.navy : Colors.white.withAlpha(235),
        foregroundColor: dark ? Colors.white : AppColors.navy,
        disabledBackgroundColor: Colors.white.withAlpha(150),
        disabledForegroundColor: AppColors.textMuted,
        fixedSize: Size(size, size),
      ),
    );
  }
}

class ProfileAvatarButton extends StatelessWidget {
  const ProfileAvatarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.person_outline_rounded,
      label: 'Profil',
      dark: true,
      size: 44,
      onPressed: () => showComingSoon(context, 'Halaman profil'),
    );
  }
}
