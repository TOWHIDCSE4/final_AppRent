import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.bgColor = AppColor.primaryColor,
    this.height = 40,
    this.width = double.infinity,
    this.radius = 6,
    this.onTap,
  });

  final String title;
  final Color bgColor;
  final double height;
  final double width;
  final double radius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
