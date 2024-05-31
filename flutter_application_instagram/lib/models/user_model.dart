import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userUid;
  final String email;
  final String userName;
  final String bio;
  final String profileImageUrl;
  final List<dynamic> followers;
  final List<dynamic> following;
  UserModel(
      {required this.userUid,
      required this.email,
      required this.userName,
      required this.bio,
      required this.profileImageUrl,
      required this.followers,
      required this.following});

  factory UserModel.formSnap(DocumentSnapshot snap) {
    log(snap.data().toString());
    Map<String, dynamic> data = (snap.data()) as Map<String, dynamic>;
    return UserModel(
        userUid: data['uid'],
        email: data['email'],
        userName: data['userName'],
        bio: data['bio'],
        profileImageUrl: data['ProfileImageUrl'],
        followers: data['followers'],
        following: data['following']);
  }
  Map<String, dynamic> toJosn() {
    return {
      'uid': userUid,
      'email': email,
      'userName': userName,
      'bio': bio,
      'ProfileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following
    };
  }
}
