import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/core/app_text_styles.dart';
import 'package:safeflow_parrain/navigation/app_router.dart';

/// Point d'entrée de l'application.
/// Si vous utilisez Firebase, initialiser Firebase avant runApp.
void main() {
  // Exemple Firebase (si activé) :
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const ProviderScope(child: SafeFlowParrainApp()));
}

class SafeFlowParrainApp extends StatelessWidget {
  const SafeFlowParrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SafeFlow Parrain',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        textTheme: AppTextStyles.textTheme,
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
