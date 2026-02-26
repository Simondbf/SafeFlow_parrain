import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/data/repositories/filleul_repository.dart';
import 'package:safeflow_parrain/models/filleul_model.dart';
import 'package:safeflow_parrain/data/repositories/mock_filleul_repository_impl.dart';
// import 'package:safeflow_parrain/data/repositories/firebase_filleul_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

/// Provider du repository : swapper l'implémentation ici pour passer en prod.
final filleulRepositoryProvider = Provider<FilleulRepository>((ref) {
  return MockFilleulRepository();
  // Pour Firebase : return FirebaseFilleulRepository(FirebaseFirestore.instance);
});

/// Provider asynchrone exposant la liste de filleuls (AsyncValue géré automatiquement).
final filleulsProvider = FutureProvider<List<Filleul>>((ref) async {
  final repo = ref.watch(filleulRepositoryProvider);
  return repo.fetchFilleuls();
});

/// Actions (mutations) centralisées pour ajouter / modifier / supprimer.
/// Invalide le provider de liste pour forcer rechargement.
final filleulActionsProvider = Provider<FilleulActions>((ref) {
  final repo = ref.watch(filleulRepositoryProvider);
  return FilleulActions(ref, repo);
});

class FilleulActions {
  final Ref ref;
  final FilleulRepository repo;
  FilleulActions(this.ref, this.repo);

  Future<void> add(Filleul f) async {
    await repo.addFilleul(f);
    ref.invalidate(filleulsProvider);
  }

  Future<void> update(Filleul f) async {
    await repo.updateFilleul(f);
    ref.invalidate(filleulsProvider);
  }

  Future<void> delete(String id) async {
    await repo.deleteFilleul(id);
    ref.invalidate(filleulsProvider);
  }
}
