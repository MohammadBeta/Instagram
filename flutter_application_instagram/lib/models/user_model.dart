import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userUid;
  final String email;
  final String userName;
  final String bio;
  final String profileImageUrl;
  final List<String> followers;
  final List<String> following;
  UserModel(
      {required this.userUid,
      required this.email,
      required this.userName,
      required this.bio,
      required this.profileImageUrl,
      required this.followers,
      required this.following});

  factory UserModel.formSnap(DocumentSnapshot snap) {
    Map data = snap.data as Map;
    return UserModel(
        userUid: data['userUid'],
        email: data['email'],
        userName: data['userName'],
        bio: data['bio'],
        profileImageUrl: data['profileImageUrl'],
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
