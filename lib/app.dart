import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/data/datasources/skin_local_data_source.dart';
import 'package:skin_sense/data/repositories/skin_repository_impl.dart';
import 'package:skin_sense/presentation/app_routes.dart';
import 'package:skin_sense/presentation/cubit/navigation_cubit.dart';
import 'package:skin_sense/presentation/cubit/skin_cubit.dart';
import 'package:skin_sense/presentation/pages/main_shell_page.dart';
import 'package:skin_sense/presentation/pages/onboarding_page.dart';
import 'package:skin_sense/presentation/theme/app_theme.dart';

class SkinSenseApp extends StatelessWidget {
  const SkinSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (_) => SkinCubit(const SkinRepositoryImpl(SkinLocalDataSource())),
        ),
      ],
      child: MaterialApp(
        title: 'SkinSense ID',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        initialRoute: AppRoutes.onboarding,
        routes: {
          AppRoutes.onboarding: (_) => const OnboardingPage(),
          AppRoutes.shell: (_) => const MainShellPage(),
        },
      ),
    );
  }
}
