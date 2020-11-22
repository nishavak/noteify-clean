import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference

  final CollectionReference noteCollection =
      Firestore.instance.collection('notes');
  final CollectionReference labelCollection =
      Firestore.instance.collection('labels');

  Stream<QuerySnapshot> get notes {
    return noteCollection.snapshots();
  }
}
