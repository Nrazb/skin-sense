import 'package:flutter/material.dart';
import 'package:skin_sense/domain/entities/skin_analysis.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/app_bars.dart';
import 'package:skin_sense/presentation/widgets/circle_icon_button.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';
import 'package:skin_sense/presentation/widgets/info_chip.dart';
import 'package:skin_sense/presentation/widgets/primary_button.dart';
import 'package:skin_sense/presentation/widgets/ratio_bar.dart';
import 'package:skin_sense/presentation/widgets/sky_background.dart';
import 'package:skin_sense/presentation/widgets/soft_card.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key, required this.analysis});

  final SkinAnalysis analysis;

  static Route<void> route({required SkinAnalysis analysis}) =>
      MaterialPageRoute(builder: (_) => RecommendationPage(analysis: analysis));

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  bool _careTab = true;

  void _save() => showComingSoon(context, 'Penyimpanan riwayat');

  @override
  Widget build(BuildContext context) {
    final a = widget.analysis;
    return SkyBackground(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ResultTopBar(title: 'Hasil Analisis'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HASIL ANALISIS DERMATOLOGI',
                                  style: appText(
                                    11,
                                    weight: FontWeight.w800,
                                    color: AppColors.accentText,
                                    spacing: 0.5,
                                  ),
                                ),
                                Text(
                                  'Rekomendasi untukmu',
                                  style: appText(
                                    14,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleIconButton(
                            icon: Icons.share_outlined,
                            label: 'Bagikan hasil',
                            size: 44,
                            onPressed: () =>
                                showComingSoon(context, 'Bagikan hasil'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _StatusCard(analysis: a),
                      const SizedBox(height: 14),
                      _NeedProfileCard(analysis: a),
                      const SizedBox(height: 14),
                      _Tabs(
                        careSelected: _careTab,
                        onChanged: (v) => setState(() => _careTab = v),
                      ),
                      const SizedBox(height: 14),
                      if (_careTab)
                        ..._careContent(a)
                      else
                        const _ProductsComingSoon(),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: AppColors.line)),
                ),
                child: PrimaryButton(
                  label: 'Simpan ke Riwayat',
                  leading: Icons.bookmark_border_rounded,
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _careContent(SkinAnalysis a) => [
    _RoutineCard(
      icon: Icons.wb_sunny_outlined,
      title: 'Rutinitas Pagi',
      subtitle: '${a.morningRoutine.length} Tahapan esensial',
      badge: 'Harian',
      steps: a.morningRoutine,
    ),
    const SizedBox(height: 14),
    _RoutineCard(
      icon: Icons.nightlight_outlined,
      title: 'Rutinitas Malam',
      subtitle: '${a.nightRoutine.length} Tahapan pemulihan',
      badge: 'Malam Hari',
      steps: a.nightRoutine,
    ),
    const SizedBox(height: 14),
    _IngredientsCard(
      recommended: a.recommendedIngredients,
      avoided: a.avoidedIngredients,
    ),
  ];
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.analysis});

  final SkinAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyLift, AppColors.navyDeep],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STATUS KULIT',
                  style: appText(
                    11,
                    weight: FontWeight.w700,
                    color: Colors.white.withAlpha(215),
                    spacing: 0.6,
                  ),
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: analysis.dominantType.displayName,
                        style: appText(
                          15,
                          weight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: SizedBox(
                            width: 6,
                            height: 6,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.accentBright,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: analysis.priorityNote,
                        style: appText(
                          14,
                          weight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NeedProfileCard extends StatelessWidget {
  const _NeedProfileCard({required this.analysis});

  final SkinAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final n = analysis.needs;
    return SoftCard(
      radius: 24,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.tune_rounded, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Profil Kebutuhan',
                  style: appText(15, weight: FontWeight.w700),
                ),
              ),
              InfoChip(
                label: 'Keyakinan ${(analysis.confidence * 100).round()}%',
                size: 11,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _NeedRow(label: 'Kontrol Minyak', percent: n.oilControl),
          const SizedBox(height: 14),
          _NeedRow(label: 'Hidrasi', percent: n.hydration),
          const SizedBox(height: 14),
          _NeedRow(label: 'Kelembutan', percent: n.smoothness),
        ],
      ),
    );
  }
}

class _NeedRow extends StatelessWidget {
  const _NeedRow({required this.label, required this.percent});

  final String label;
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: appText(15, weight: FontWeight.w700)),
            Text('$percent%', style: appText(15, weight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 8),
        RatioBar(value: percent / 100, label: label, height: 7),
      ],
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.careSelected, required this.onChanged});

  final bool careSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(235),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Perawatan',
              icon: Icons.spa_outlined,
              selected: careSelected,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Produk',
              icon: Icons.shopping_bag_outlined,
              selected: !careSelected,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : AppColors.navy;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: selected ? AppColors.navy : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: appText(14, weight: FontWeight.w700, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.steps,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;
  final List<RoutineStep> steps;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 24,
      padding: const EdgeInsets.all(18),
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
                child: Icon(icon, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: appText(15, weight: FontWeight.w700)),
                    Text(
                      subtitle,
                      style: appText(12, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              InfoChip(label: badge, size: 11),
            ],
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < steps.length; i++)
            _StepTile(
              index: i + 1,
              step: steps[i],
              isLast: i == steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.step,
    required this.isLast,
  });

  final int index;
  final RoutineStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.navy,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: appText(
                    12,
                    weight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: AppColors.tintStrong),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title, style: appText(15, weight: FontWeight.w700)),
                  if (step.frequency != null) ...[
                    const SizedBox(height: 4),
                    InfoChip(
                      label: step.frequency!,
                      background: AppColors.accentTint,
                      foreground: AppColors.accentText,
                      size: 11,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: appText(13, color: AppColors.textMuted, height: 1.4),
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

class _IngredientsCard extends StatelessWidget {
  const _IngredientsCard({required this.recommended, required this.avoided});

  final List<String> recommended;
  final List<String> avoided;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 24,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.thumb_up_alt_outlined,
                size: 20,
                color: AppColors.accentText,
              ),
              const SizedBox(width: 8),
              Text(
                'Bahan aktif yang cocok',
                style: appText(15, weight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final name in recommended)
                InfoChip(
                  label: name,
                  icon: Icons.check_circle_outline_rounded,
                  size: 13,
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.block_rounded,
                size: 20,
                color: AppColors.accentText,
              ),
              const SizedBox(width: 8),
              Text(
                'Bahan yang dihindari',
                style: appText(15, weight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final name in avoided)
                InfoChip(
                  label: name,
                  icon: Icons.cancel_outlined,
                  background: AppColors.accentTint,
                  foreground: AppColors.accentText,
                  size: 13,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductsComingSoon extends StatelessWidget {
  const _ProductsComingSoon();

  @override
  Widget build(BuildContext context) {
    return const SoftCard(
      radius: 24,
      child: ComingSoonView(
        title: 'Rekomendasi produk',
        message:
            'Peringkat produk sesuai anggaran sedang disiapkan. Sementara itu, gunakan daftar bahan aktif di tab Perawatan sebagai acuan.',
      ),
    );
  }
}
