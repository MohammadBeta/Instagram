import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/models/post_model.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
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
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.postModel.postDescription)
                  ])),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8).copyWith(top: 0),
                  child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "View all 500 comments",
                        style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.normal),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8).copyWith(top: 0),
                  child: Text(
                    DateTime.now().toString(),
                    style: const TextStyle(
                        color: secondaryColor, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
