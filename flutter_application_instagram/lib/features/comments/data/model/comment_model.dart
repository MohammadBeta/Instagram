import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String userUid;
  final String userName;
  final String profileImageUrl;
  final String commentText;
  final String postId;
  final List<dynamic> likes;
  CommentModel(
      {required this.userUid,
      required this.userName,
      required this.profileImageUrl,
      required this.commentText,
      required this.likes,
      required this.postId,
      });

  factory CommentModel.formSnap(DocumentSnapshot snap) {
    log(snap.data().toString());
    Map<String, dynamic> data = (snap.data()) as Map<String, dynamic>;
    return CommentModel(
        userUid: data['userUid'],
        userName: data['userName'],
        profileImageUrl: data['ProfileImageUrl'],
        commentText: data['commentText'],
        likes: data['likes'] ?? [],
        postId: data['postId'] ?? 0,
        );
  }
  Map<String, dynamic> toJosn() {
    return {
      'userUid': userUid,
      'userName': userName,
      'ProfileImageUrl': profileImageUrl,
      'commentText': commentText,
      'likes': likes,
      'postId': postId,
    };
  }
}
