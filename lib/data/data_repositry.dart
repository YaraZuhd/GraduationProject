import 'package:cloud_firestore/cloud_firestore.dart';

import './data_model.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('DataModel');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addDataModel(DataModel datam) {
    return collection.add(datam.toJson());
  }

  // 4
  void updateDataModel(DataModel datam) async {
    await collection.doc(datam.referenceId).update(datam.toJson());
  }

  // 5
  void deleteDataModel(DataModel datam) async {
    await collection.doc(datam.referenceId).delete();
  }
}
