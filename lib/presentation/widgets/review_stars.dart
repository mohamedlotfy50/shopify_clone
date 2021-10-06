import 'package:flutter/material.dart';

class ReviewStars extends StatelessWidget {
  final double count;
  const ReviewStars({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      height: 25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Icon(
            count.round() > index ? Icons.star : Icons.star_border,
            size: 20,
            color: Colors.yellow,
          );
        },
      ),
    );
  }
}
