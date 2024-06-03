import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/screens/profile_screen.dart';

class UserSearchResult extends StatelessWidget {
  const UserSearchResult(
      {super.key,
      required this.userName,
      required this.userUid,
      required this.profileIamgeUrl});
  final String userName;
  final String userUid;
  final String profileIamgeUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreen(userUid: userUid)));
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileIamgeUrl),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(userName),
          )
        ],
      ),
    );
  }
}
