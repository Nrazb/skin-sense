import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/presentation/cubit/navigation_cubit.dart';
import 'package:skin_sense/presentation/pages/home_page.dart';
import 'package:skin_sense/presentation/pages/scan_page.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';
import 'package:skin_sense/presentation/widgets/sky_background.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, index) {
        return SkyBackground(
          child: Scaffold(
            body: Stack(
              children: [
                SafeArea(
                  bottom: false,
                  child: IndexedStack(
                    index: index,
                    children: const [
                      HomePage(),
                      ScanPage(),
                      ComingSoonView(
                        title: 'Riwayat',
                        message:
                            'Daftar hasil scan yang tersimpan sedang disiapkan.',
                      ),
                      ComingSoonView(
                        title: 'Profil',
                        message:
                            'Pengaturan akun dan preferensi kulit sedang disiapkan.',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 12 + MediaQuery.paddingOf(context).bottom,
                  child: FloatingNavBar(
                    index: index,
                    onSelected: context.read<NavigationCubit>().select,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.index,
    required this.onSelected,
  });

  final int index;
  final ValueChanged<int> onSelected;

  static const _items = <(IconData, String)>[
    (Icons.home_outlined, 'Beranda'),
    (Icons.crop_free_rounded, 'Scan'),
    (Icons.history_rounded, 'Riwayat'),
    (Icons.account_circle_outlined, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    // Satu-satunya elemen yang mengambang permanen, jadi hanya ia yang berbayang tebal.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withAlpha(60),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < _items.length; i++)
            _NavItem(
              icon: _items[i].$1,
              label: _items[i].$2,
              selected: i == index,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        focusColor: Colors.white.withAlpha(50),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, minHeight: 56),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withAlpha(46)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 22, color: Colors.white),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: appText(
                  11,
                  weight: FontWeight.w700,
                  color: selected ? Colors.white : Colors.white.withAlpha(200),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
