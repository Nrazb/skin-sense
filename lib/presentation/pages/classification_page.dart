import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/domain/entities/skin_analysis.dart';
import 'package:skin_sense/presentation/cubit/skin_cubit.dart';
import 'package:skin_sense/presentation/pages/recommendation_page.dart';
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

class ClassificationPage extends StatelessWidget {
  const ClassificationPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const ClassificationPage());

  @override
  Widget build(BuildContext context) {
    return SkyBackground(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ResultTopBar(title: 'Hasil Analisis'),
              Expanded(
                child: BlocBuilder<SkinCubit, SkinState>(
                  builder: (context, state) => switch (state) {
                    SkinLoading() => const LoadingView(
                      message: 'Menganalisis foto wajahmu',
                    ),
                    SkinFailure(:final message) => ErrorView(
                      message: message,
                      onRetry: context.read<SkinCubit>().load,
                    ),
                    SkinLoaded(:final analysis) => _Result(analysis: analysis),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({required this.analysis});

  final SkinAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final percent = (analysis.confidence * 100).round();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_outlined, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'AI Dermatologi',
                  style: appText(13, weight: FontWeight.w700),
                ),
              ),
              CircleIconButton(
                icon: Icons.share_outlined,
                label: 'Bagikan hasil',
                size: 44,
                onPressed: () => showComingSoon(context, 'Bagikan hasil'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _HeroResult(analysis: analysis, percent: percent),
          const SizedBox(height: 16),
          SoftCard(
            radius: 24,
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.bar_chart_rounded, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Probabilitas Tiap Kelas',
                        style: appText(16, weight: FontWeight.w800),
                      ),
                    ),
                    const InfoChip(label: 'AI Output', size: 10),
                  ],
                ),
                const SizedBox(height: 16),
                for (final entry in analysis.ranked) ...[
                  _ProbabilityRow(
                    type: entry.key,
                    value: entry.value,
                    dominant: entry.key == analysis.dominantType,
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          SoftCard(
            radius: 24,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.tint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.psychology_alt_outlined,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Apa Artinya?',
                      style: appText(16, weight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(analysis.meaning, style: appText(14, height: 1.6)),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.tint,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Catatan khusus: ',
                                style: appText(12, weight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: analysis.specialNote,
                                style: appText(
                                  12,
                                  color: AppColors.textMuted,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.health_and_safety_outlined,
                size: 18,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Informasi bersifat edukatif dan bukan pengganti saran dokter spesialis kulit.',
                  style: appText(12, color: AppColors.textMuted, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Lanjut ke Profil Kulit',
            forward: true,
            onPressed: () => Navigator.of(
              context,
            ).push(RecommendationPage.route(analysis: analysis)),
          ),
        ],
      ),
    );
  }
}

class _HeroResult extends StatelessWidget {
  const _HeroResult({required this.analysis, required this.percent});

  final SkinAnalysis analysis;
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyLift, AppColors.navyDeep],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: SizedBox(
                      width: 68,
                      height: 84,
                      child: const ColoredBox(
                        color: AppColors.navyLift,
                        child: Icon(
                          Icons.face_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TIPE KULIT TERDETEKSI',
                      style: appText(
                        11,
                        weight: FontWeight.w700,
                        color: Colors.white.withAlpha(210),
                        spacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      analysis.dominantType.displayName,
                      style: appText(
                        26,
                        weight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InfoChip(
                      label: 'Keyakinan $percent%',
                      dotColor: AppColors.accentBright,
                      background: Colors.white.withAlpha(30),
                      foreground: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.white.withAlpha(220),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Foto wajah dipindai',
                  style: appText(
                    12,
                    weight: FontWeight.w600,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ),
              InfoChip(
                label: '${analysis.scanWidthPx} px scan',
                background: Colors.white.withAlpha(30),
                foreground: Colors.white,
                size: 11,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProbabilityRow extends StatelessWidget {
  const _ProbabilityRow({
    required this.type,
    required this.value,
    required this.dominant,
  });

  final SkinType type;
  final double value;
  final bool dominant;

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();
    return Column(
      children: [
        Row(
          children: [
            Text(
              type.className,
              style: appText(
                dominant ? 16 : 14,
                weight: dominant ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            if (dominant) ...[
              const SizedBox(width: 8),
              const InfoChip(
                label: 'Dominan',
                background: AppColors.accentTint,
                foreground: AppColors.accentText,
                size: 10,
              ),
            ],
            const Spacer(),
            Text(
              '$percent%',
              style: appText(
                dominant ? 17 : 14,
                weight: dominant ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RatioBar(
          value: value,
          label: 'Peluang ${type.className}',
          color: dominant ? AppColors.accentBright : const Color(0xFFF3A3B1),
        ),
      ],
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.navy),
          const SizedBox(height: 16),
          Text(
            message,
            style: appText(
              14,
              weight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.tint,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: appText(18, weight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: appText(14, color: AppColors.textMuted, height: 1.5),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onAction,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  side: const BorderSide(color: AppColors.navy),
                  shape: const StadiumBorder(),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => _MessageView(
    icon: Icons.error_outline_rounded,
    title: 'Terjadi kendala',
    message: message,
    actionLabel: 'Coba lagi',
    onAction: onRetry,
  );
}
