import 'package:flutter/material.dart';
import '../../services/user_data.dart';
import '../widgets/filleul_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filleuls = UserData.getFilleuls(); // Liste (vide pour l'instant)
    final screenWidth = MediaQuery.of(context).size.width; // Pour responsive
    final isLargeScreen = screenWidth > 600; // Tablette/desktop

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de bord',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isLargeScreen ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec profil parrain (pur texte)
            Container(
              padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade900],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bonjour, Alexandre!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Parrain niveau Gold',
                    style: TextStyle(
                      color: Colors.blue.shade100,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '12,540 points',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isLargeScreen ? 32 : 24),

            // Liste complète des filleuls
            const Text(
              'Mes Filleuls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (filleuls.isEmpty)
              const Center(
                child: Text(
                  'Aucun filleul pour le moment',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            else if (isLargeScreen) // Grille pour tablette (2 colonnes)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5, // Ajusté pour texte
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filleuls.length,
                itemBuilder: (context, index) {
                  final filleul = filleuls[index];
                  return FilleulCard(
                    id: filleul.id,
                    nom: filleul.nom,
                    dateInscription: filleul.dateInscription,
                    status: filleul.status,
                  );
                },
              )
            else // Liste pour mobile
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filleuls.length,
                itemBuilder: (context, index) {
                  final filleul = filleuls[index];
                  return FilleulCard(
                    id: filleul.id,
                    nom: filleul.nom,
                    dateInscription: filleul.dateInscription,
                    status: filleul.status,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
