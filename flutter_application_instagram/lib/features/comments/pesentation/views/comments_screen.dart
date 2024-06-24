import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/features/comments/data/model/comment_model.dart';
import 'package:flutter_application_instagram/features/comments/pesentation/widgets/comment_card.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/firebase/firestore_methods.dart';
import '../../../../user_cubit/user_cubit.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<CommentModel> comments = [];
  Future<void> loadComments() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .get();

    data.docs.asMap().forEach((key, value) {
      comments.add(CommentModel.formSnap(value));
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Future loadMoreComments() {}

  Future<void> addComment(
      UserModel user, String text, BuildContext context) async {
    String result = await FireStoreMethods().addPostComment(
      widget.postId,
      user.userName,
      user.userUid,
      user.profileImageUrl,
      _commentController.text,
    );

    if (result != "success") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      _commentController.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    loadComments();

    _scrollController.addListener(() {
      log(_scrollController.position.maxScrollExtent.toString());
      log(_scrollController.position.minScrollExtent.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = BlocProvider.of<UserCubit>(context, listen: false).user;
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10)
              .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profileImageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: TextField(
                        maxLines: null,
                        controller: _commentController,
                        decoration: InputDecoration(
                            hintText: "Comment as ${user.userName}"),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await addComment(user, _commentController.text, context);
                    loadComments();
                  },
                  icon: const Icon(Icons.send)),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Comments"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: _isLoading == false
            ? ListView.builder(
                controller: _scrollController,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentCard(commentModel: comments[index]);
                })
            : const CircularProgressIndicator());
  }
}
