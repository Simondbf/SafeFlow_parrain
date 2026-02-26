import 'package:flutter/material.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/models/filleul_model.dart';

/// Carte filleul réutilisable. Fournit onTap pour navigation vers détail.
class FilleulCard extends StatelessWidget {
  final Filleul filleul;
  final VoidCallback? onTap;
  const FilleulCard({super.key, required this.filleul, this.onTap});

  Color _statutColor() {
    switch (filleul.statut) {
      case 'Actif':
        return AppColors.actif;
      case 'Inactif':
        return AppColors.inactif;
      default:
        return AppColors.enAttente;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statutColor();
    final date = '${filleul.dateInscription.day.toString().padLeft(2,'0')}/'
                 '${filleul.dateInscription.month.toString().padLeft(2,'0')}/'
                 '${filleul.dateInscription.year}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(filleul.nom, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('ID : ${filleul.id}', style: Theme.of(context).textTheme.labelMedium),
            Text('Inscrit le $date', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
              child: Text(filleul.statut, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ]),
        ),
      ),
    );
  }
}
