import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/presentation/cubit/navigation_cubit.dart';
import 'package:skin_sense/presentation/cubit/skin_cubit.dart';
import 'package:skin_sense/presentation/pages/classification_page.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';
import 'package:skin_sense/presentation/widgets/app_bars.dart';
import 'package:skin_sense/presentation/widgets/circle_icon_button.dart';
import 'package:skin_sense/presentation/widgets/coming_soon.dart';
import 'package:skin_sense/presentation/widgets/dashed_path.dart';

/// Tampilan hardcode: belum memakai kamera. Tombol Pindai membuka hasil contoh.
class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  void _scan(BuildContext context) {
    context.read<SkinCubit>().load();
    Navigator.of(context).push(ClassificationPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BrandHeader(title: 'Scan'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, kNavClearance),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleIconButton(
                      icon: Icons.arrow_back_rounded,
                      label: 'Kembali ke Beranda',
                      onPressed: () =>
                          context.read<NavigationCubit>().select(AppTab.home),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Pindai Wajah',
                            style: appText(18, weight: FontWeight.w800),
                          ),
                          Text(
                            'ANALISIS DERMATOLOGI',
                            style: appText(
                              10,
                              weight: FontWeight.w700,
                              color: AppColors.textMuted,
                              spacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleIconButton(
                      icon: Icons.help_outline_rounded,
                      label: 'Bantuan',
                      onPressed: () =>
                          showComingSoon(context, 'Bantuan pemindaian'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _Viewfinder(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ControlLabel(
                      label: 'Galeri',
                      child: CircleIconButton(
                        icon: Icons.photo_library_outlined,
                        label: 'Pilih foto dari galeri',
                        size: 56,
                        onPressed: () =>
                            showComingSoon(context, 'Pilih dari galeri'),
                      ),
                    ),
                    _ControlLabel(
                      label: 'Pindai',
                      child: _ShutterButton(onPressed: () => _scan(context)),
                    ),
                    _ControlLabel(
                      label: 'Putar',
                      child: CircleIconButton(
                        icon: Icons.flip_camera_android_outlined,
                        label: 'Putar kamera',
                        size: 56,
                        onPressed: () =>
                            showComingSoon(context, 'Putar kamera'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.tint,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.visibility_outlined,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Pastikan seluruh wajah terlihat tanpa kacamata atau masker',
                          style: appText(
                            12,
                            color: AppColors.textMuted,
                            height: 1.35,
                          ),
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
    );
  }
}

class _Viewfinder extends StatelessWidget {
  const _Viewfinder();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.82,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // [FOTO] pengganti pratinjau kamera sampai kamera dipasang.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF3B5F8F), AppColors.navy],
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.face_rounded,
                size: 180,
                color: Colors.white.withAlpha(40),
              ),
            ),
            const CustomPaint(painter: _GuidePainter()),
            Positioned(
              top: 14,
              left: 14,
              right: 14,
              child: _Pill(
                icon: Icons.wb_sunny_outlined,
                text: 'Posisikan wajah di bingkai, pastikan cahaya cukup',
              ),
            ),
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: _Pill(
                icon: Icons.warning_amber_rounded,
                text: 'Wajah tidak terdeteksi, coba hadap lurus ke kamera',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(225),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: appText(12, weight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlLabel extends StatelessWidget {
  const _ControlLabel({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        const SizedBox(height: 6),
        Text(
          label,
          style: appText(
            12,
            weight: FontWeight.w700,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ShutterButton extends StatelessWidget {
  const _ShutterButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Pindai wajah',
      excludeSemantics: true,
      child: InkResponse(
        onTap: onPressed,
        radius: 48,
        child: Container(
          width: 84,
          height: 84,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: AppColors.accentBright, width: 3),
          ),
        ),
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    const inset = 28.0;
    final w = size.width;
    final h = size.height;
    canvas.drawPath(cornerBracket(const Offset(inset, 70), 1, 1), paint);
    canvas.drawPath(cornerBracket(Offset(w - inset, 70), -1, 1), paint);
    canvas.drawPath(cornerBracket(Offset(inset, h - 70), 1, -1), paint);
    canvas.drawPath(cornerBracket(Offset(w - inset, h - 70), -1, -1), paint);
    final oval = Rect.fromCenter(
      center: Offset(w / 2, h * 0.5),
      width: w * 0.62,
      height: h * 0.6,
    );
    canvas.drawPath(
      dashPath(Path()..addOval(oval), dash: 6, gap: 6),
      paint
        ..strokeWidth = 1.8
        ..color = Colors.white.withAlpha(235),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
