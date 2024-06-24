import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_instagram/features/comments/data/model/comment_model.dart';
import 'package:flutter_application_instagram/features/home/data/model/post_model.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/features/search/data/model/user_search_result_model.dart';
import 'package:flutter_application_instagram/core/firebase/storage_methods.dart';
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
          likes: 0,
          postId: postId);
      await _firestore.collection('posts').doc(postId).set(post.toJosn());
      result = "success";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> addPostComment(String postId, String userName, String userUid,
      String profileImageUrl, String text) async {
    String result = "An error has occurred";
    try {
      String commentId = const Uuid().v1();
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(CommentModel(
              commentText: text,
              userName: userName,
              userUid: userUid,
              profileImageUrl: profileImageUrl,
              postId: postId,
              likes: []).toJosn());
      result = "success";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<List<UserSearchResultModel>> searchUser(String userName) async {
    List<UserSearchResultModel> usersList = [];
    if (userName.isEmpty) {
      return <UserSearchResultModel>[];
    }
    final QuerySnapshot<Map<String, dynamic>> users = await _firestore
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: userName)
        .orderBy('userName', descending: false)
        .get();
    if (users.size == 0 || users.docs.isEmpty) {
      return <UserSearchResultModel>[];
    }
    users.docs
        .map((e) => {
              usersList.add(UserSearchResultModel(
                  userUid: e.data()['uid'].toString(),
                  userName: e.data()['userName'].toString(),
                  profileImageUrl: e.data()['ProfileImageUrl'].toString()))
            })
        .toList();
    return usersList;
  }

  Future<UserModel> getUserByUid(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('users').doc(uid).get();

    return UserModel.formSnap(data);
  }

  Future<int> getPostsCount(String uid) async {
    AggregateQuerySnapshot data = await _firestore
        .collection('posts')
        .where('userUid', isEqualTo: uid)
        .count()
        .get();
    if (data.count == null) {
      return 0;
    }
    return data.count!;
  }

  Future<void> followUser(String currentUserUid, String targetUser) async {
    List<dynamic> targetUserFollowers =
        (await _firestore.collection('users').doc(targetUser).get())
            .data()!['followers'];
    List<dynamic> currentUserFollowing =
        (await _firestore.collection('users').doc(currentUserUid).get())
            .data()!['following'];

    bool isFollowBefore = false;
    targetUserFollowers.asMap().forEach((key, value) {
      if (value == currentUserUid) {
        isFollowBefore = true;
      }
    });
    if (isFollowBefore == false) {
      targetUserFollowers.add(currentUserUid);
      currentUserFollowing.add(targetUser);
    }
    await _firestore.collection('users').doc(targetUser).update({
      'followers': isFollowBefore
          ? FieldValue.arrayRemove([currentUserUid])
          : FieldValue.arrayUnion(targetUserFollowers)
    });
    await _firestore.collection('users').doc(currentUserUid).update({
      'following': isFollowBefore
          ? FieldValue.arrayRemove([targetUser])
          : FieldValue.arrayUnion(currentUserFollowing)
    });
  }
}
