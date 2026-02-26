// Template Firebase — adapter si vous activez cloud_firestore.
// Ne pas oublier d'initialiser Firebase dans main.dart si vous utilisez cette implémentation.

import 'package:safeflow_parrain/models/filleul_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFilleulRepository implements FilleulRepository {
  // final FirebaseFirestore _firestore;
  // FirebaseFilleulRepository(this._firestore);

  @override
  Future<List<Filleul>> fetchFilleuls() async {
    // Exemple d'implémentation :
    // final snap = await _firestore.collection('filleuls').get();
    // return snap.docs.map((d) => Filleul.fromJson(d.data())).toList();
    throw UnimplementedError('Brancher FirebaseFilleulRepository avec cloud_firestore');
  }

  @override
  Future<void> addFilleul(Filleul f) async {
    // await _firestore.collection('filleuls').doc(f.id).set(f.toJson());
    throw UnimplementedError();
  }

  @override
  Future<void> updateFilleul(Filleul f) async {
    // await _firestore.collection('filleuls').doc(f.id).update(f.toJson());
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFilleul(String id) async {
    // await _firestore.collection('filleuls').doc(id).delete();
    throw UnimplementedError();
  }
}
