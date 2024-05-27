import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> uploadFile(String childName, Uint8List file) async {
    Reference storageRef = _firebaseStorage
        .ref()
        .child(childName)
        .child(_firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = storageRef.putData(file);
    await uploadTask;
    return await uploadTask.snapshot.ref.getDownloadURL();
  }
}
