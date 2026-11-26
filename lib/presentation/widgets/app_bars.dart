import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/circle_icon_button.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      child: Row(
        children: [
          // [LOGO] placeholder sampai aset logo resmi tersedia.
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.spa_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SKINSENSE ID',
                  style: appText(
                    11,
                    weight: FontWeight.w700,
                    color: AppColors.textMuted,
                    spacing: 0.6,
                  ),
                ),
                Text(
                  title,
                  style: appText(18, weight: FontWeight.w800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => showComingSoon(context, 'Notifikasi'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const ProfileAvatarButton(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

/// Bilah atas untuk halaman hasil yang dibuka di atas navigasi utama.
class ResultTopBar extends StatelessWidget {
  const ResultTopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            label: 'Kembali',
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: appText(18, weight: FontWeight.w800)),
          ),
          const ProfileAvatarButton(),
        ],
      ),
    );
  }
}
