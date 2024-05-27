import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  final Uint8List? image;
  final void Function()? onPressed;

  const ProfileImagePicker(
      {super.key, required this.image, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: image != null
              ? MemoryImage(image!) as ImageProvider
              : const NetworkImage(
                  'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                ),
        ),
        Positioned(
            bottom: -10,
            right: -5,
            child: IconButton(
                color: primaryColor,
                onPressed: onPressed,
                icon: const Icon(Icons.add_a_photo)))
      ],
    );
  }
}
