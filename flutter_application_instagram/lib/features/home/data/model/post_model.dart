import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userUid;
  final String userName;
  final String postDescription;
  final String postImageUrl;
  final String profileImageUrl;
  final String postId;
  final int likes;
  PostModel(
      {required this.userUid,
      required this.userName,
      required this.profileImageUrl,
      required this.postImageUrl,
      required this.postDescription,
      required this.likes,
      required this.postId,
      });

  factory PostModel.formSnap(DocumentSnapshot snap) {
    log(snap.data().toString());
    Map<String, dynamic> data = (snap.data()) as Map<String, dynamic>;
    return PostModel(
      userUid: data['userUid'],
      userName: data['userName'],
      profileImageUrl: data['ProfileImageUrl'],
      postImageUrl: data['postImageUrl'],
      postDescription: data['postDescription'],
      likes: data['likes'] ?? 0,
      postId: data['postId'] ?? '',
    );
  }
  Map<String, dynamic> toJosn() {
    return {
      'userUid': userUid,
      'userName': userName,
      'ProfileImageUrl': profileImageUrl,
      'postDescription': postDescription,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'postId': postId,
    };
  }
}
