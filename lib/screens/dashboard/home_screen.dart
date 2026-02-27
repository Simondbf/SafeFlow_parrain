import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/providers/filleul_provider.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/filleul_card.dart';
import 'widgets/skeleton_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filleulsAsync = ref.watch(filleulsProvider);
    final isLarge = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO au merge feat/auth : ref.watch(parrainProvider)
            const DashboardHeader(
              title:    'Bonjour, Alexandre !',
              subtitle: 'Parrain niveau Gold',
              points:   '12 540 points',
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    ref.read(filleulActionsProvider).refresh(),
                child: filleulsAsync.when(

                  loading: () => ListView.builder(
                    itemCount:   5,
                    padding:     EdgeInsets.all(isLarge ? 24 : 16),
                    itemBuilder: (_, __) => const SkeletonCard(),
                  ),

                  error: (e, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                          color: AppColors.inactif, size: 48),
                        const SizedBox(height: 12),
                        Text('Erreur : $e',
                          textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () =>
                            ref.refresh(filleulsProvider.future),
                          icon:  const Icon(Icons.refresh),
                          label: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),

                  data: (filleuls) {
                    if (filleuls.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline,
                              size: 64, color: AppColors.textSecondary),
                            SizedBox(height: 16),
                            Text('Aucun filleul pour le moment',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              )),
                          ],
                        ),
                      );
                    }

                    final pad = EdgeInsets.all(isLarge ? 24 : 16);

                    if (isLarge) {
                      return GridView.builder(
                        padding: pad,
                        gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 380,
                            mainAxisExtent:     160,
                            mainAxisSpacing:    12,
                            crossAxisSpacing:   12,
                          ),
                        itemCount:   filleuls.length,
                        itemBuilder: (_, i) =>
                          FilleulCard(filleul: filleuls[i]),
                      );
                    }

                    return ListView.builder(
                      padding:     pad,
                      itemCount:   filleuls.length,
                      itemBuilder: (_, i) =>
                        FilleulCard(filleul: filleuls[i]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
