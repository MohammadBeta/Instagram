import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResponsiveMobileLayout extends StatefulWidget {
  const ResponsiveMobileLayout({super.key});

  @override
  State<ResponsiveMobileLayout> createState() => _ResponsiveMobileLayoutState();
}

class _ResponsiveMobileLayoutState extends State<ResponsiveMobileLayout> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> fetchUserName() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();f
    Map data = doc.data() as Map;
    return data['userName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("This is Mobile Layout"),
          onPressed: () async {
            print(await fetchUserName());
          },
        ),
      ),
    );
  }
}
