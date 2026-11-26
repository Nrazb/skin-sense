import 'package:flutter/material.dart';
import 'package:skin_sense/presentation/app_routes.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/circle_icon_button.dart';
import 'package:skin_sense/presentation/widgets/dashed_path.dart';
import 'package:skin_sense/presentation/widgets/info_chip.dart';
import 'package:skin_sense/presentation/widgets/primary_button.dart';
import 'package:skin_sense/presentation/widgets/ratio_bar.dart';
import 'package:skin_sense/presentation/widgets/sky_background.dart';
import 'package:skin_sense/presentation/widgets/soft_card.dart';

class _Slide {
  const _Slide(
    this.visual,
    this.stage,
    this.title,
    this.description,
    this.highlights,
  );

  final Widget visual;
  final String stage;
  final String title;
  final String description;
  final List<(IconData, String)> highlights;
}

const _slides = [
  _Slide(
    FaceScanIllustration(),
    'EDUKASI AI • LANGKAH 1/3',
    'Kenali Tipe Kulitmu',
    'Foto wajahmu, biarkan AI menganalisis tipe kulitmu secara presisi dan objektif.',
    [
      (Icons.verified_outlined, 'Deteksi Akurat CNN'),
      (Icons.lock_open_outlined, 'Tanpa Login'),
      (Icons.lock_outline_rounded, 'Privasi Aman'),
    ],
  ),
  _Slide(
    RoutinePreview(),
    'Perawatan Terstandar • Langkah 2/3',
    'Rekomendasi yang Personal',
    'Dapatkan rutinitas pagi dan malam sesuai kebutuhan kulitmu.',
    [
      (Icons.event_repeat_outlined, 'Rutinitas Pagi & Malam'),
      (Icons.query_stats_rounded, 'Fuzzy-SAW Engine'),
      (Icons.verified_user_outlined, 'Bahan Terverifikasi'),
    ],
  ),
  _Slide(
    BudgetPreview(),
    'KURASI PRODUK • LANGKAH 3/3',
    'Produk Sesuai Anggaran',
    'Peringkat produk skincare berdasarkan bahan dan budget-mu tanpa kompromi kualitas.',
    [
      (Icons.task_alt_rounded, 'BPOM Terdaftar'),
      (Icons.shopping_bag_outlined, 'Merek Lokal Terpilih'),
      (Icons.shield_outlined, 'Filter Bebas Iritan'),
    ],
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() => Navigator.of(context).pushReplacementNamed(AppRoutes.shell);

  void _goTo(int page) => _controller.animateToPage(
    page,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOut,
  );

  @override
  Widget build(BuildContext context) {
    final index = _index;
    final isLast = index == _slides.length - 1;
    return SkyBackground(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Row(
                  children: [
                    CircleIconButton(
                      icon: Icons.chevron_left_rounded,
                      label: 'Langkah sebelumnya',
                      onPressed: index == 0 ? null : () => _goTo(index - 1),
                    ),
                    Expanded(
                      child: Text(
                        'Skin Scan Intro',
                        textAlign: TextAlign.center,
                        style: appText(17, weight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const ProfileAvatarButton(),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _slides.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (_, i) => _SlideCard(
                      slide: _slides[i],
                      dotColor: i == 0
                          ? AppColors.accentBright
                          : AppColors.navy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _slides.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == index ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == index
                            ? AppColors.navy
                            : AppColors.tintStrong,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: PrimaryButton(
                  label: isLast ? 'Mulai Sekarang' : 'Lanjut',
                  forward: true,
                  onPressed: isLast ? _finish : () => _goTo(index + 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideCard extends StatelessWidget {
  const _SlideCard({required this.slide, required this.dotColor});

  final _Slide slide;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    final stage = InfoChip(label: slide.stage, dotColor: dotColor, size: 11);
    final stageAfterVisual = slide.visual is BudgetPreview;
    return SoftCard(
      lifted: true,
      radius: 28,
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (!stageAfterVisual) ...[stage, const SizedBox(height: 16)],
            slide.visual,
            if (stageAfterVisual) ...[const SizedBox(height: 20), stage],
            const SizedBox(height: 20),
            Text(
              slide.title,
              textAlign: TextAlign.center,
              style: appText(28, weight: FontWeight.w800, height: 1.15),
            ),
            const SizedBox(height: 10),
            Text(
              slide.description,
              textAlign: TextAlign.center,
              style: appText(15, color: AppColors.textMuted, height: 1.45),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final h in slide.highlights)
                  InfoChip(label: h.$2, icon: h.$1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Ilustrasi pindai wajah: menjelaskan bahwa T-zone dan U-zone dianalisis.
class FaceScanIllustration extends StatelessWidget {
  const FaceScanIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Ilustrasi wajah dengan bingkai pindai',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF1F6FD), Color(0xFFE3EDFA)],
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1.08,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _FacePainter())),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.grid_view_rounded, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'T-Zone & U-Zone AI',
                          style: appText(11, weight: FontWeight.w700),
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
    );
  }
}

class _FacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h * 0.46;

    final bracket = Paint()
      ..color = AppColors.navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    const inset = 18.0;
    canvas.drawPath(cornerBracket(const Offset(inset, inset), 1, 1), bracket);
    canvas.drawPath(cornerBracket(Offset(w - inset, inset), -1, 1), bracket);
    canvas.drawPath(cornerBracket(Offset(inset, h - inset), 1, -1), bracket);
    canvas.drawPath(
      cornerBracket(Offset(w - inset, h - inset), -1, -1),
      bracket,
    );

    final guide = Paint()
      ..color = AppColors.tintStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (final scale in [1.0, 0.86]) {
      final rect = Rect.fromCenter(
        center: Offset(cx, cy),
        width: w * 0.62 * scale,
        height: h * 0.80 * scale,
      );
      canvas.drawPath(dashPath(Path()..addOval(rect), dash: 4, gap: 4), guide);
    }

    final face = Rect.fromCenter(
      center: Offset(cx, cy),
      width: w * 0.34,
      height: h * 0.56,
    );
    canvas.drawOval(face, Paint()..color = const Color(0xFFE8EFFA));
    final line = Paint()
      ..color = AppColors.navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawOval(face, line);

    final eyeY = cy - h * 0.06;
    for (final side in [-1.0, 1.0]) {
      final ex = cx + side * w * 0.07;
      canvas.drawLine(
        Offset(ex - w * 0.035, eyeY - h * 0.035),
        Offset(ex + w * 0.035, eyeY - h * 0.04),
        line..strokeWidth = 1.6,
      );
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(ex, eyeY),
          width: w * 0.06,
          height: h * 0.03,
        ),
        0,
        3.14159,
        false,
        line,
      );
    }
    canvas.drawLine(Offset(cx, eyeY), Offset(cx, cy + h * 0.06), line);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, cy + h * 0.14),
        width: w * 0.10,
        height: h * 0.05,
      ),
      0.2,
      2.7,
      false,
      line,
    );

    final navyDot = Paint()..color = AppColors.navy;
    final coral = Paint()..color = AppColors.accentBright;
    canvas.drawCircle(Offset(cx, face.top + 8), 3, navyDot);
    canvas.drawCircle(Offset(cx, face.bottom - 8), 3, navyDot);
    canvas.drawCircle(Offset(cx - w * 0.09, cy + h * 0.04), 3.5, coral);
    canvas.drawCircle(Offset(cx + w * 0.09, cy + h * 0.04), 3.5, coral);

    final scanY = cy - h * 0.02;
    final shader = const LinearGradient(
      colors: [Color(0x00FF6B81), AppColors.accentBright, Color(0x00FF6B81)],
    ).createShader(Rect.fromLTWH(0, scanY, w, 1));
    canvas.drawLine(
      Offset(w * 0.06, scanY),
      Offset(w * 0.94, scanY),
      Paint()
        ..shader = shader
        ..strokeWidth = 1.6,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Contoh ilustrasi rutinitas untuk onboarding, bukan hasil analisis pengguna.
class RoutinePreview extends StatelessWidget {
  const RoutinePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SessionTile(
          icon: Icons.wb_sunny_outlined,
          tint: Color(0xFFD5EAF5),
          label: 'TAHAP PAGI',
          steps: 'Cleanser, Serum, Sunscreen',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.water_drop_outlined,
                size: 16,
                color: AppColors.textMuted,
              ),
              const Expanded(
                child: Divider(
                  indent: 8,
                  endIndent: 8,
                  color: AppColors.tintStrong,
                ),
              ),
              const Icon(
                Icons.spa_outlined,
                size: 16,
                color: AppColors.textMuted,
              ),
              const Expanded(
                child: Divider(
                  indent: 8,
                  endIndent: 8,
                  color: AppColors.tintStrong,
                ),
              ),
              const Icon(
                Icons.wb_twilight_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const _SessionTile(
          icon: Icons.nightlight_outlined,
          tint: Color(0xFFDCE3FA),
          label: 'TAHAP MALAM',
          steps: 'Double Cleanse, Moisturizer',
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Expanded(
              child: _PhotoTile(
                label: 'Serum Aktif',
                icon: Icons.science_outlined,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PhotoTile(
                label: 'Pelembap Barrier',
                icon: Icons.water_drop_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.icon,
    required this.tint,
    required this.label,
    required this.steps,
  });

  final IconData icon;
  final Color tint;
  final String label;
  final String steps;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 20,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            child: Icon(icon, size: 22),
          ),
          const SizedBox(width: 12),
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
                Text(
                  steps,
                  style: appText(15, weight: FontWeight.w800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.tint,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_outline_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}

// [FOTO] placeholder sampai foto produk asli disediakan.
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF3B5F8F), AppColors.navy],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(icon, color: Colors.white.withAlpha(90), size: 28),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              label,
              style: appText(12, weight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contoh ilustrasi peringkat produk untuk onboarding, bukan produk nyata.
class BudgetPreview extends StatelessWidget {
  const BudgetPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: 0,
              left: 20,
              right: 20,
              child: Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(190),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.line),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.spa_outlined,
                      size: 22,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Hydra Calming Toner',
                        style: appText(
                          11,
                          weight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '#2 Pilihan',
                      style: appText(
                        11,
                        weight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: SoftCard(
                lifted: true,
                radius: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const InfoChip(
                          label: '#1 TERBAIK',
                          background: AppColors.navy,
                          foreground: Colors.white,
                          size: 11,
                        ),
                        const SizedBox(width: 8),
                        const InfoChip(label: 'Hemat 35%', size: 11),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.accentTint,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bookmark_rounded,
                            size: 20,
                            color: AppColors.accentText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        // [FOTO] placeholder kemasan produk.
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.tint,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.science_outlined,
                            size: 26,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ceramide Soothing Gel',
                                style: appText(17, weight: FontWeight.w800),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Rp 89.000',
                                style: appText(15, weight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kecocokan Kulit',
                          style: appText(
                            11,
                            weight: FontWeight.w600,
                            color: AppColors.textMuted,
                          ),
                        ),
                        Text(
                          '87% Sesuai',
                          style: appText(11, weight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const RatioBar(
                      value: 0.87,
                      label: 'Kecocokan kulit',
                      height: 7,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.tint,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              const Icon(Icons.payments_outlined, size: 18),
              const SizedBox(width: 8),
              Text(
                'Batas Anggaran:',
                style: appText(
                  12,
                  weight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Text('< Rp 100.000', style: appText(12, weight: FontWeight.w800)),
            ],
          ),
        ),
      ],
    );
  }
}
