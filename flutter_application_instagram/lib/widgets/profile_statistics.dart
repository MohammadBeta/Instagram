import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';

class ProfileStatistics extends StatelessWidget {
  const ProfileStatistics(
      {super.key, required this.title, required this.count});
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count.toString(),
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold)),
        Text(
          title,
          style: const TextStyle(color: secondaryColor, fontSize: 12),
        ),
      ],
    );
  }
}
