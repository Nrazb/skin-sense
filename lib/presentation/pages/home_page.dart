import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/presentation/app_routes.dart';
import 'package:skin_sense/presentation/cubit/navigation_cubit.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/app_bars.dart';
import 'package:skin_sense/presentation/widgets/circle_icon_button.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';
import 'package:skin_sense/presentation/widgets/info_chip.dart';
import 'package:skin_sense/presentation/widgets/primary_button.dart';
import 'package:skin_sense/presentation/widgets/soft_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _guideKey = GlobalKey();

  void _scrollToGuide() {
    final target = _guideKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BrandHeader(title: 'Beranda'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, kNavClearance),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.accentBright,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'SELAMAT DATANG DI SKINSENSE',
                                  style: appText(
                                    11,
                                    weight: FontWeight.w700,
                                    color: AppColors.textMuted,
                                    spacing: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Halo! Yuk kenali kulitmu',
                            style: appText(
                              28,
                              weight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleIconButton(
                      icon: Icons.chevron_left_rounded,
                      label: 'Lihat pengenalan aplikasi',
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.onboarding),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                HeroScanCard(
                  onScan: () =>
                      context.read<NavigationCubit>().select(AppTab.scan),
                  onGuide: _scrollToGuide,
                ),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        icon: Icons.verified_outlined,
                        label: 'MODEL CNN',
                        value: '98.4% Akurasi',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatTile(
                        icon: Icons.lock_open_outlined,
                        label: 'AKSES TAMU',
                        value: 'Tanpa Login',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const PhotoTipsCard(),
                const SizedBox(height: 16),
                KeyedSubtree(key: _guideKey, child: const SkinGuideCard()),
                const SizedBox(height: 16),
                const CurationTile(),
                const SizedBox(height: 12),
                const EducationNote(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HeroScanCard extends StatelessWidget {
  const HeroScanCard({super.key, required this.onScan, required this.onGuide});

  final VoidCallback onScan;
  final VoidCallback onGuide;

  @override
  Widget build(BuildContext context) {
    // Titik fokus Beranda: satu-satunya blok gelap dengan gradasi navy.
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyLift, AppColors.navyDeep],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoChip(
            label: 'Edukasi Tipe Kulit AI',
            icon: Icons.face_retouching_natural_outlined,
            background: Colors.white.withAlpha(30),
            foreground: Colors.white,
          ),
          const SizedBox(height: 18),
          Text(
            'Analisis Kondisi Wajah Secara Akurat & Personal',
            style: appText(
              25,
              weight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Ambil 1 foto wajah untuk klasifikasi tipe kulit CNN dan rekomendasi produk lokal terkurasi.',
            style: appText(
              14,
              color: Colors.white.withAlpha(225),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Scan Sekarang',
                  leading: Icons.photo_camera_outlined,
                  onPressed: onScan,
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                tooltip: 'Lihat panduan tipe kulit',
                onPressed: onGuide,
                icon: const Icon(Icons.menu_book_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(30),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(56, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.tint,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: appText(
                    10,
                    weight: FontWeight.w700,
                    color: AppColors.textMuted,
                    spacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: appText(15, weight: FontWeight.w800, height: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoTipsCard extends StatelessWidget {
  const PhotoTipsCard({super.key});

  static const _tips = [
    _Tip(
      Icons.wb_sunny_outlined,
      'Cahaya Cukup',
      'Hindari bayangan tajam atau backlight agar kontur jelas.',
    ),
    _Tip(
      Icons.face_retouching_off_outlined,
      'Tanpa Makeup',
      'Agar tekstur dan pori kulit wajah terbaca dengan akurat.',
    ),
    _Tip(
      Icons.filter_vintage_outlined,
      'Tanpa Filter',
      'Pertahankan warna alami dan saturasi asli kulit wajah.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 28,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 2, 2, 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.tint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lightbulb_outline_rounded, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tips Foto yang Baik',
                    style: appText(17, weight: FontWeight.w800),
                  ),
                ),
                InfoChip(label: '${_tips.length} Langkah', size: 11),
              ],
            ),
          ),
          for (final tip in _tips)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SoftCard(
                radius: 18,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.tint,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(tip.icon, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.title,
                            style: appText(15, weight: FontWeight.w800),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            tip.description,
                            style: appText(
                              12,
                              color: AppColors.textMuted,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SkinGuideCard extends StatelessWidget {
  const SkinGuideCard({super.key});

  static const guides = [
    _Guide(
      Icons.sentiment_satisfied_alt_outlined,
      'Normal',
      'Seimbang',
      'Keseimbangan minyak & hidrasi ideal, pori halus dan tekstur kenyal tanpa sensasi berminyak.',
      'Proteksi',
    ),
    _Guide(
      Icons.water_drop_outlined,
      'Berminyak',
      'Sebum aktif',
      'Produksi sebum berlebih, rentan kilap di area T-zone dan pori tampak lebih besar.',
      'Kontrol Sebum',
    ),
    _Guide(
      Icons.grain_rounded,
      'Kering',
      'Kurang lembap',
      'Minyak dan kadar air rendah, kulit terasa kencang, kusam, dan mudah mengelupas.',
      'Hidrasi & Barrier',
    ),
    _Guide(
      Icons.contrast_rounded,
      'Kombinasi',
      'Dua karakter',
      'T-zone cenderung berminyak sementara pipi normal hingga kering.',
      'Keseimbangan Zona',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 28,
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EKSPLORASI DERMATOLOGI',
                        style: appText(
                          10,
                          weight: FontWeight.w700,
                          color: AppColors.textMuted,
                          spacing: 0.6,
                        ),
                      ),
                      Text(
                        'Panduan Tipe Kulit',
                        style: appText(19, weight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Geser',
                  style: appText(
                    13,
                    weight: FontWeight.w700,
                    color: AppColors.accentText,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: AppColors.accentText,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final g in guides)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 232,
                        child: SoftCard(
                          radius: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: AppColors.tint,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(g.icon, size: 20),
                                  ),
                                  const Spacer(),
                                  InfoChip(label: g.tag, size: 11),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                g.name,
                                style: appText(20, weight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                g.description,
                                style: appText(
                                  13,
                                  color: AppColors.textMuted,
                                  height: 1.4,
                                ),
                              ),
                              const Spacer(),
                              const SizedBox(height: 10),
                              Text(
                                'Fokus: ${g.focus}',
                                style: appText(
                                  12,
                                  weight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurationTile extends StatelessWidget {
  const CurationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 22,
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => showComingSoon(context, 'Katalog produk lokal'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // [FOTO] placeholder sampai foto produk asli disediakan.
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.tint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'KURASI LOKAL',
                            style: appText(
                              10,
                              weight: FontWeight.w800,
                              color: AppColors.accentText,
                              spacing: 0.5,
                            ),
                          ),
                          TextSpan(
                            text: '  •  Segera hadir',
                            style: appText(10, weight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Skincare Lokal Terkurasi',
                      style: appText(16, weight: FontWeight.w800),
                    ),
                    Text(
                      'Bahan aktif disesuaikan otomatis pasca scan.',
                      style: appText(
                        12,
                        color: AppColors.textMuted,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class EducationNote extends StatelessWidget {
  const EducationNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.tint,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.medical_services_outlined, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Informasi bersifat edukatif, bukan diagnosis medis pengganti dokter spesialis kulit.',
              style: appText(12, color: AppColors.textMuted, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tip {
  const _Tip(this.icon, this.title, this.description);

  final IconData icon;
  final String title;
  final String description;
}

class _Guide {
  const _Guide(this.icon, this.name, this.tag, this.description, this.focus);

  final IconData icon;
  final String name;
  final String tag;
  final String description;
  final String focus;
}
