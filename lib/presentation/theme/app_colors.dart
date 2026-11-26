import 'package:flutter/material.dart';

/// Inti: navy + biru langit. Aksen tunggal: koral, dalam tiga takaran.
abstract final class AppColors {
  static const navy = Color(0xFF072D59);
  static const skyTop = Color(0xFFDBF2FC); // Seal Blue
  static const accent = Color(0xFFFD6E88); // Creamson Pink

  static const navyDeep = navy;
  static const navyLift = Color(0xFF2A4A70); // navy + 14% putih
  static const accentBright = accent;
  static const accentText = accent;
  static const accentTint = Color(0xFFFEE2E7); // pink 20%

  static const surface = Color(0xFFFFFFFF);
  static const tint = Color(0xFFE9F7FD); // seal blue 60%
  static const tintStrong = Color(0xFFCDD5DE); // navy 20%
  static const line = Color(0xFFE6EAEE); // navy 10%
  static const track = Color(0xFFE1E6EB); // navy 12%
  static const textMuted = Color(0xFF516C8B); // navy 70%
}
