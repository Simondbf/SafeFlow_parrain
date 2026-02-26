import 'package:flutter/material.dart';
import 'package:safeflow_parrain/core/app_colors.dart';

/// Header réutilisable avec gradient et responsive padding.
/// Paramétrable pour afficher nom, niveau, points.
class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String points;

  const DashboardHeader({
    super.key,
    this.title = 'Bonjour, Parrain',
    this.subtitle = 'Niveau: —',
    this.points = '0 points',
  });

  @override
  Widget build(BuildContext context) {
    final isLarge = MediaQuery.of(context).size.width > 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLarge ? 28 : 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: isLarge ? 22 : 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: Colors.blue.shade100, fontSize: 13)),
        const SizedBox(height: 10),
        Text(points, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
