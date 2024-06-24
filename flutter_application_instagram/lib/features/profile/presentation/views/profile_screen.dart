import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/providors/user_providor.dart';
import 'package:flutter_application_instagram/core/firebase/firestore_methods.dart';
import 'package:flutter_application_instagram/core/widgets/custom_button.dart';
import 'package:flutter_application_instagram/features/profile/presentation/widgets/profile_statistics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userUid;

  const ProfileScreen({super.key, required this.userUid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? _postsCount;
  @override
  void initState() {
    super.initState();
  }

  Future<UserModel> getUserInfo(String userUid) async {
    return await Provider.of<UserProvider>(context, listen: false)
        .getUserByUid(userUid);
  }

  @override
  Widget build(BuildContext context) {
    String currentUserUid = Provider.of<UserProvider>(context).user.userUid;
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            instagramLogo,
            color: primaryColor,
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.message_outlined))
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userUid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  bool isFollwed = false;
                  isFollwed =
                      (snapshot.data!.data()!['followers'] as List<dynamic>)
                          .contains(currentUserUid);
                  log(isFollwed.toString());
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  snapshot.data!.data()!['ProfileImageUrl']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (_postsCount != null)
                                          ProfileStatistics(
                                            title: "Posts",
                                            count: _postsCount!,
                                          )
                                        else
                                          FutureBuilder(
                                              future: FireStoreMethods()
                                                  .getPostsCount(
                                                      widget.userUid),
                                              builder: (context,
                                                  AsyncSnapshot<int> snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    _postsCount =
                                                        snapshot.data!;
                                                    return ProfileStatistics(
                                                      title: "Posts",
                                                      count: _postsCount!,
                                                    );
                                                  }
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                _postsCount = 0;
                                                return const ProfileStatistics(
                                                  title: "Posts",
                                                  count: 0,
                                                );
                                              }),
                                        ProfileStatistics(
                                            title: "Followers",
                                            count: (snapshot.data!
                                                    .data()!['followers'])
                                                .length),
                                        ProfileStatistics(
                                          title: "Following",
                                          count: (snapshot.data!
                                                  .data()!['following'])
                                              .length,
                                        ),
                                      ],
                                    ),
                                    if (snapshot.data!.data()!['uid'] !=
                                        currentUserUid)
                                      Container(
                                          margin: const EdgeInsets.all(8)
                                              .copyWith(left: 50, right: 50),
                                          height: 35,
                                          child: Material(
                                            color: isFollwed
                                                ? blueColor
                                                : secondaryColor,
                                            child: InkWell(
                                              splashColor: isFollwed
                                                  ? secondaryColor
                                                  : blueColor,
                                              onTap: () async {
                                                FireStoreMethods().followUser(
                                                    currentUserUid,
                                                    snapshot.data!
                                                        .data()!['uid']);
                                              },
                                              child: CustomButton(
                                                widget: Text(isFollwed
                                                    ? "Un Follow"
                                                    : "Follow"),
                                                vertical: 0,
                                                color: null,
                                              ),
                                            ),
                                          ))
                                    else
                                      Container(
                                          margin: const EdgeInsets.all(8)
                                              .copyWith(left: 50, right: 50),
                                          height: 35,
                                          child: Material(
                                            color: blueColor,
                                            child: InkWell(
                                              splashColor: secondaryColor,
                                              onTap: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                              },
                                              child: const CustomButton(
                                                widget: Text("Sign Out"),
                                                vertical: 0,
                                                color: null,
                                              ),
                                            ),
                                          ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                snapshot.data!.data()!['userName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                snapshot.data!.data()!['bio'],
                                style: const TextStyle(
                                    fontSize: 14, color: secondaryColor),
                              ),
                            ],
                          ),
                        )
                      ]);
                }

                return const Center(
                  child: Text('No Profile Found'),
                );
              },
            ),
          ),
        ));
  }
}
