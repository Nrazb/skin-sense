import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';

/// Tombol aksi utama. Panah ke kanan hanya dipakai saat tombol memajukan langkah.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.forward = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leading;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.tintStrong,
          disabledForegroundColor: AppColors.navy,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: appText(16, weight: FontWeight.w700, color: Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              Icon(leading, size: 20),
              const SizedBox(width: 10),
            ],
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            if (forward) ...[
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
