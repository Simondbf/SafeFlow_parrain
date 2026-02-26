import 'package:safeflow_parrain/models/filleul_model.dart';

/// Contrat (interface) du repository.
/// Permet de swapper Mock <-> Firebase sans changer le reste de l'app.
abstract class FilleulRepository {
  Future<List<Filleul>> fetchFilleuls();
  Future<void> addFilleul(Filleul f);
  Future<void> updateFilleul(Filleul f);
  Future<void> deleteFilleul(String id);
}
