import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;

  const CustomButton({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const ShapeDecoration(
        color: blueColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      child: widget,
    );
  }
}
