import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/providers/filleul_provider.dart';
import 'package:safeflow_parrain/screens/dashboard/widgets/filleul_card.dart';

/// Écran de recherche / listing détaillé des filleuls.
/// Fournit un champ de recherche côté client.
class FilleulsScreen extends ConsumerStatefulWidget {
  const FilleulsScreen({super.key});

  @override
  ConsumerState<FilleulsScreen> createState() => _FilleulsScreenState();
}

class _FilleulsScreenState extends ConsumerState<FilleulsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filleulsAsync = ref.watch(filleulsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mes Filleuls', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1, color: AppColors.divider)),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (v) => setState(() => _query = v.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Rechercher par nom ou ID...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
            ),
          ),
        ),
        Expanded(
          child: filleulsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur : $e')),
            data: (filleuls) {
              final filtered = filleuls.where((f) => f.nom.toLowerCase().contains(_query) || f.id.toLowerCase().contains(_query)).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text('Aucun résultat', style: TextStyle(color: AppColors.textSecondary)));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (_, i) => FilleulCard(filleul: filtered[i]),
              );
            },
          ),
        ),
      ]),
    );
  }
}
