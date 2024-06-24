import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/features/home/data/model/post_model.dart';
import 'package:flutter_application_instagram/features/comments/pesentation/views/comments_screen.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Future<int> _getCommentsCount(String postId) async {
    var commentsSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    int count = commentsSnapshot.size;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCommentsCount(widget.postModel.postId),
        builder: (context, snapshot) {
          int count = 0;
          if (snapshot.hasData) {
            count = snapshot.data!;
          }
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(widget.postModel.profileImageUrl),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.postModel.userName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_outlined))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.height * 0.50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.postModel.postImageUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                    const Expanded(child: SizedBox()),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_add_outlined)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.postModel.likes} likes',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${widget.postModel.userName}: ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: widget.postModel.postDescription)
                        ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8)
                            .copyWith(top: 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommentsScreen(
                                      postId: widget.postModel.postId)));
                            },
                            child: Text(
                              "View all $count comments",
                              style: const TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8)
                            .copyWith(top: 0),
                        child: Text(
                          DateTime.now().toString(),
                          style: const TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
