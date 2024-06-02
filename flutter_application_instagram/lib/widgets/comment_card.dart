import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/models/comment_model.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.commentModel});
  final CommentModel commentModel;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.commentModel.profileImageUrl),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxHeight: 300,
                      minHeight: 60,
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          widget.commentModel.userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mobileBackgroundColor,
                              fontSize: 16),
                        ),
                      ),
                      Text(
                        widget.commentModel.commentText,
                        style: const TextStyle(color: mobileBackgroundColor),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 40,
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Row(
                    children: [
                      Text(
                        "${DateTime.now().hour}:${DateTime.now().minute}",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: secondaryColor, fontSize: 13),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            size: 20,
                          ))
                    ],
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
