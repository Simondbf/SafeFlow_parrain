import 'dart:async';
import 'package:safeflow_parrain/models/filleul_model.dart';
import 'filleul_repository.dart';

/// Implémentation en mémoire pour développement et tests locaux.
/// Fournit un comportement synchrone simulé (délai réseau).
class MockFilleulRepository implements FilleulRepository {
  final List<Filleul> _store = [
    // Exemple de seed data (désactivé par défaut)
    // Filleul(id: 'u1', nom: 'Marie Dupont', dateInscription: DateTime.now().subtract(Duration(days: 30)), statut: 'Actif'),
  ];

  @override
  Future<List<Filleul>> fetchFilleuls() async {
    await Future.delayed(const Duration(milliseconds: 300)); // simule latence
    return List.unmodifiable(_store);
  }

  @override
  Future<void> addFilleul(Filleul f) async {
    _store.add(f);
  }

  @override
  Future<void> updateFilleul(Filleul f) async {
    final i = _store.indexWhere((e) => e.id == f.id);
    if (i >= 0) _store[i] = f;
  }

  @override
  Future<void> deleteFilleul(String id) async {
    _store.removeWhere((e) => e.id == id);
  }
}
