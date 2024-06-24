import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final double vertical;
  final Color? color;

  const CustomButton({
    super.key,
    required this.widget,
    this.vertical = 10,
    this.color = blueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: vertical),
      decoration: ShapeDecoration(
        color: color,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      child: widget,
    );
  }
}
