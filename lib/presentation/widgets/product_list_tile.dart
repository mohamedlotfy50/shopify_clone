import 'package:flutter/material.dart';
import 'package:shopify/infrastructure/models/product.dart';
import 'package:shopify/presentation/widgets/animated_check_box.dart';
import 'package:shopify/presentation/widgets/circle_background_image.dart';

class ProductListTile extends StatelessWidget {
  Color getBackgroundColor(int index) {
    index += 1;
    if (index == 1 || index % 4 == 0 && index != 4) {
      return Color(0xFFFCD5BA);
    } else if (index % 2 == 0 && index != 4) {
      return Color(0xFFC2F1FE);
    } else if (index % 3 == 0) {
      return Color(0xFF9BF59E);
    } else {
      return Color(0xFFF8F48D);
    }
  }

  final int index;
  final Product product;
  final isDeleteActive;
  final Widget trailing;
  const ProductListTile({
    Key? key,
    required this.index,
    required this.isDeleteActive,
    required this.trailing,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedCheckBox(
            product: product,
            isActive: isDeleteActive,
          ),
          AnimatedContainer(
            width: isDeleteActive ? size.width - 90 : size.width - 30,
            duration: Duration(milliseconds: 250),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  child: CircleBackgroundImage(
                    color: getBackgroundColor(index),
                    image: product.image,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: !isDeleteActive ? 180 : size.width - 250,
                      child: Flexible(
                        child: Text(
                          product.title,
                          style: TextStyle(color: Colors.green[400]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: Container()),
                trailing,
              ],
            ),
          )
        ],
      ),
    );
  }
}
