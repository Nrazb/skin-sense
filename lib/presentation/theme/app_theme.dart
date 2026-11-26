import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skin_sense/presentation/theme/app_colors.dart';

/// Plus Jakarta Sans: huruf geometris ramah yang dipakai pada desain acuan.
TextStyle appText(
  double size, {
  FontWeight weight = FontWeight.w500,
  Color color = AppColors.navy,
  double? height,
  double? spacing,
}) => GoogleFonts.plusJakartaSans(
  fontSize: size,
  fontWeight: weight,
  color: color,
  height: height,
  letterSpacing: spacing,
);

/// Ruang kosong di bawah halaman agar konten tidak tertutup navigasi melayang.
const double kNavClearance = 104;

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.navy,
    primary: AppColors.navy,
    secondary: AppColors.accent,
    surface: AppColors.surface,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: AppColors.navy,
      displayColor: AppColors.navy,
    ),
    iconTheme: const IconThemeData(color: AppColors.navy),
    focusColor: AppColors.navy.withAlpha(36),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.navy),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.navy,
        textStyle: appText(14, weight: FontWeight.w700),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.navy,
      contentTextStyle: appText(
        14,
        weight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
