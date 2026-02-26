import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/providers/filleul_provider.dart';
import 'package:safeflow_parrain/screens/dashboard/widgets/dashboard_header.dart';
import 'package:safeflow_parrain/screens/dashboard/widgets/filleul_card.dart';

/// Écran d'accueil : header + liste / grille responsive des filleuls.
/// Utilise AsyncValue pour gérer loading / data / error.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filleulsAsync = ref.watch(filleulsProvider);
    final isLarge = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DashboardHeader(title: 'Bonjour, Simon !', subtitle: 'Parrain niveau Gold', points: '12 540 points'),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(filleulsProvider.future),
              child: filleulsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.error_outline, color: AppColors.inactif, size: 48),
                    const SizedBox(height: 12),
                    Text('Erreur : $e', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => ref.refresh(filleulsProvider.future),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Réessayer'),
                    ),
                  ]),
                ),
                data: (filleuls) {
                  if (filleuls.isEmpty) {
                    return const Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.people_outline, size: 64, color: AppColors.textSecondary),
                        SizedBox(height: 16),
                        Text('Aucun filleul pour le moment', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                      ]),
                    );
                  }

                  final padding = EdgeInsets.all(isLarge ? 24 : 16);

                  if (isLarge) {
                    // Grille pour tablettes / grands écrans
                    return GridView.builder(
                      padding: padding,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 380,
                        mainAxisExtent: 160,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: filleuls.length,
                      itemBuilder: (_, i) => FilleulCard(filleul: filleuls[i]),
                    );
                  }

                  // Liste pour mobiles
                  return ListView.builder(
                    padding: padding,
                    itemCount: filleuls.length,
                    itemBuilder: (_, i) => FilleulCard(filleul: filleuls[i]),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
