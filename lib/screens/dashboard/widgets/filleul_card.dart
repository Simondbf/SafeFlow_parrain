import 'package:flutter/material.dart';

class FilleulCard extends StatelessWidget {
  final String id;
  final String nom;
  final String dateInscription;
  final String status;

  const FilleulCard({
    super.key,
    required this.id,
    required this.nom,
    required this.dateInscription,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Couleurs par statut
    Color statusColor;
    switch (status) {
      case 'Actif':
        statusColor = Colors.green;
        break;
      case 'Inactif':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text('ID: $id', style: const TextStyle(color: Colors.grey)),
            Text('Inscrit le: $dateInscription', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
