import 'package:flutter/material.dart';
import 'package:safeflow_parrain/core/app_colors.dart';

/// Carte placeholder animée affichée pendant le chargement.
/// Remplace le CircularProgressIndicator — UX bien meilleure.
class SkeletonCard extends StatefulWidget {
  const SkeletonCard({super.key});

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>   _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bar(double width) => FadeTransition(
    opacity: _anim,
    child: Container(
      width:  width,
      height: 12,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color:        AppColors.divider,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:    const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(180),
            _bar(120),
            _bar(140),
            const SizedBox(height: 4),
            FadeTransition(
              opacity: _anim,
              child: Container(
                width:  60,
                height: 20,
                decoration: BoxDecoration(
                  color:        AppColors.divider,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
