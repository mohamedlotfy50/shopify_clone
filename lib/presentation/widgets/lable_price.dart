import 'package:flutter/material.dart';

class LablePrice extends StatelessWidget {
  final String lable;
  final double price;
  const LablePrice({Key? key, required this.lable, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$lable:',
          style: TextStyle(
              color: Colors.green[400],
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black45),
        ),
      ],
    );
  }
}
