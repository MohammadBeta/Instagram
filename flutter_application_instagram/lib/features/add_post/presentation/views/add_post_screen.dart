import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/firebase/firestore_methods.dart';
import 'package:flutter_application_instagram/core/utilis/functions/image_picker.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../user_cubit/user_cubit.dart';

class AddPostScreenState extends StatefulWidget {
  const AddPostScreenState({super.key});

  @override
  State<AddPostScreenState> createState() => _AddPostScreenStateState();
}

class _AddPostScreenStateState extends State<AddPostScreenState> {
  Uint8List? _postImage;
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;
  void _selectPostImage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Upload Image"),
            children: [
              SimpleDialogOption(
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();

                  var image = await pickImage(ImageSource.camera);

                  setState(() {
                    _postImage = image;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();

                  var image = await pickImage(ImageSource.gallery);
                  setState(() {
                    _postImage = image;
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> publishPost(UserModel user, BuildContext context) async {
    if (_isLoading == true) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String result = await FireStoreMethods()
        .publishPost(_captionController.text, _postImage!, user);
    setState(() {
      _isLoading = false;
      clearPost();
    });
    if (result != "success") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Publishing post done successfully',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  void clearPost() {
    setState(() {
      _captionController.text = "";
      _postImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = BlocProvider.of<UserCubit>(context, listen: false).user;
    return _postImage == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectPostImage(context),
                icon: const Icon(
                  Icons.upload,
                  size: 50,
                  color: primaryColor,
                )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text("New Post"),
              leading: IconButton(
                  onPressed: () => clearPost(),
                  icon: const Icon(Icons.arrow_back)),
              actions: [
                TextButton(
                  onPressed: () async {
                    await publishPost(user, context);
                  },
                  child: const Text(
                    "Publish",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 5,
                  child: _isLoading
                      ? const LinearProgressIndicator(
                          color: primaryColor,
                        )
                      : Container(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImageUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption here..."),
                      ),
                    ),
                    const Divider()
                  ],
                ),
                Flexible(
                  child: Container(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(_postImage!), fit: BoxFit.fill)),
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ));
  }
}
