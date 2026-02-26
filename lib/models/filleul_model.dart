/// Modèle immuable représentant un filleul.
/// Fournit fromJson/toJson pour mapping avec Firestore ou autres sources.
class Filleul {
  final String id;
  final String nom;
  final DateTime dateInscription;
  final String statut; // 'Actif' | 'Inactif' | 'En attente'

  const Filleul({
    required this.id,
    required this.nom,
    required this.dateInscription,
    required this.statut,
  });

  factory Filleul.fromJson(Map<String, dynamic> json) => Filleul(
    id: json['id'] as String,
    nom: json['nom'] as String,
    dateInscription: DateTime.parse(json['dateInscription'] as String),
    statut: json['statut'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'dateInscription': dateInscription.toIso8601String(),
    'statut': statut,
  };

  /// copyWith utile pour mises à jour partielles.
  Filleul copyWith({
    String? id,
    String? nom,
    DateTime? dateInscription,
    String? statut,
  }) => Filleul(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    dateInscription: dateInscription ?? this.dateInscription,
    statut: statut ?? this.statut,
  );
}
