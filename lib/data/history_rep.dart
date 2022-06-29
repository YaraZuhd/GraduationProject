import 'package:cloud_firestore/cloud_firestore.dart';

import './data_history.dart';

class HistoryRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Hisrtory');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addHistory(DataHistory datam) {
    return collection.add(datam.toJson());
  }

  // 4
  void updateHistory(DataHistory datam) async {
    await collection.doc(datam.referenceId).update(datam.toJson());
  }

  // 5
  void deleteHistory(DataHistory datam) async {
    await collection.doc(datam.referenceId).delete();
  }
}
