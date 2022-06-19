import 'package:cloud_firestore/cloud_firestore.dart';

import './red_and_green.dart';

class DataRepositoryAreas {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('RedAndGreen');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addRedAndGreen(RedAndGreen datam) {
    return collection.add(datam.toJson());
  }

  // 4
  void updateRedAndGreen(RedAndGreen datam) async {
    await collection.doc(datam.referenceId).update(datam.toJson());
  }

  // 5
  void deleteRedAndGreen(RedAndGreen datam) async {
    await collection.doc(datam.referenceId).delete();
  }
}
