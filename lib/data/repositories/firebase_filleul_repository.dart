import 'package:safeflow_parrain/data/repositories/filleul_repository.dart';
import 'package:safeflow_parrain/models/filleul_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// ✅ implements FilleulRepository présent (bug Copilot corrigé)
// Activer les méthodes au merge feat/auth.
class FirebaseFilleulRepository implements FilleulRepository {
  // final FirebaseFirestore _db;
  // FirebaseFilleulRepository(this._db);

  @override
  Future<List<Filleul>> fetchFilleuls() async {
    // final snap = await _db.collection('filleuls').get();
    // return snap.docs.map((d) => Filleul.fromJson(d.data())).toList();
    throw UnimplementedError('Brancher cloud_firestore');
  }

  @override
  Future<void> addFilleul(Filleul f) async =>
      throw UnimplementedError();

  @override
  Future<void> updateFilleul(Filleul f) async =>
      throw UnimplementedError();

  @override
  Future<void> deleteFilleul(String id) async =>
      throw UnimplementedError();
}

// ── Firestore Rules — coller dans Firebase Console ───────────────────
// rules_version = '2';
// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /filleuls/{id} {
//       allow read, write:
//         if request.auth.uid == resource.data.parrainId;
//     }
//   }
// }
