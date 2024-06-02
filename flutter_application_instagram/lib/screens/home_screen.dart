import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/models/post_model.dart';
import 'package:flutter_application_instagram/widgets/post_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("An Error has occerrd"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PostCard(
                      postModel: PostModel.formSnap(snapshot.data!.docs[index]),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: Text('No Posts Found'),
            );
          },
        ));
  }
}
