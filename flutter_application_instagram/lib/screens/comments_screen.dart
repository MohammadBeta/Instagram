import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/models/comment_model.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/providors/user_providor.dart';
import 'package:flutter_application_instagram/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../resources/firebase/firestore_methods.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

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
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).user;
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.postId)
              .collection('comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                          commentModel: CommentModel.formSnap(
                              snapshot.data!.docs[index]));
                    });
              }
            }
            return const Center(
              child: Text("Be the first who comment"),
            );
          },
        ));
  }
}
