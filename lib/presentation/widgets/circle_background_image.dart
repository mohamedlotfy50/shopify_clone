import 'package:flutter/material.dart';
import 'package:shopify/presentation/core/app_images.dart';

class CircleBackgroundImage extends StatelessWidget {
  final Color color;
  final String image;
  const CircleBackgroundImage(
      {Key? key, required this.color, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
          padding: EdgeInsets.all(9),
          child: Image.network(image),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5))),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
