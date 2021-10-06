import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:shopify/infrastructure/models/product.dart';
import 'package:shopify/presentation/core/app_images.dart';
import 'package:shopify/presentation/widgets/circle_background_image.dart';
import 'package:shopify/presentation/widgets/custom_animated_icon.dart';
import 'package:shopify/presentation/widgets/review_stars.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final Color color;
  final void Function()? onPressed;
  ProductCard(
      {Key? key,
      required this.color,
      required this.product,
      required this.index,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomAnimatedIcon(
                  onTap: () {
                    provider.toggleFavorit(product);
                  },
                  isActive: product.isFavourite,
                  isToggleable: true,
                  icon: CupertinoIcons.heart_fill,
                  color: Colors.red,
                ),
              ],
            ),
            Expanded(
              child: CircleBackgroundImage(
                image: product.image,
                color: color,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    product.title,
                    style: TextStyle(color: Colors.green[400]),
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
                        product.price.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReviewStars(
                        count: product.rating.toDouble(),
                      ),
                      Text(
                        '(${product.rating.toStringAsFixed(1)})',
                        style: TextStyle(color: Colors.black38),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 5,
                  offset: Offset(-4, 4),
                  spreadRadius: 3)
            ]),
      ),
    );
  }
}
