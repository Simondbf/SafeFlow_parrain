import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safeflow_parrain/data/repositories/filleul_repository.dart';
import 'package:safeflow_parrain/data/repositories/mock_filleul_repository_impl.dart';
import 'package:safeflow_parrain/models/filleul_model.dart';
// Au merge feat/auth :
// import 'package:safeflow_parrain/data/repositories/firebase_filleul_repository.dart';

/// Changer cette ligne au merge feat/auth pour passer en Firebase.
final filleulRepositoryProvider = Provider<FilleulRepository>(
  (ref) => MockFilleulRepository(),
  // (ref) => FirebaseFilleulRepository(FirebaseFirestore.instance),
);

final filleulsProvider = FutureProvider<List<Filleul>>((ref) async {
  return ref.watch(filleulRepositoryProvider).fetchFilleuls();
});

final filleulActionsProvider = Provider<FilleulActions>(
  (ref) => FilleulActions(ref, ref.watch(filleulRepositoryProvider)),
);

class FilleulActions {
  final Ref _ref;
  final FilleulRepository _repo;
  FilleulActions(this._ref, this._repo);

  Future<void> add(Filleul f) async {
    try {
      await _repo.addFilleul(f);
      _ref.invalidate(filleulsProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(Filleul f) async {
    try {
      await _repo.updateFilleul(f);
      _ref.invalidate(filleulsProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _repo.deleteFilleul(id);
      _ref.invalidate(filleulsProvider);
    } catch (e) {
      rethrow;
    }
  }

  /// Pull-to-refresh explicite — attend la fin du chargement.
  Future<void> refresh() async {
    _ref.invalidate(filleulsProvider);
    return _ref.read(filleulsProvider.future);
  }
}
