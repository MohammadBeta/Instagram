import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_instagram/models/post_model.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/resources/firebase/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addDocument(
      String collection, String docName, Map<String, dynamic> fields) async {
    await _firestore.collection(collection).doc(docName).set(fields);
  }

  Future<String> publishPost(
      String postDescription, Uint8List image, UserModel user) async {
    String result = "An error has occurred";
    try {
      String postId = const Uuid().v1();
      String postImageUrl =
          await FirebaseStorageMethods().uploadPostImage(postId, image);
      PostModel post = PostModel(
          userUid: user.userUid,
          userName: user.userName,
          profileImageUrl: user.profileImageUrl,
          postImageUrl: postImageUrl,
          postDescription: postDescription,
          likes: 0);
      await _firestore.collection('posts').doc(postId).set(post.toJosn());
      result = "success";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }
}
