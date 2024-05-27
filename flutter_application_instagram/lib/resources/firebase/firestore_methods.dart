import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addDocument(
      String collection, String docName, Map<String, dynamic> fields) async {
    await _firestore.collection(collection).doc(docName).set(fields);
  }
}
