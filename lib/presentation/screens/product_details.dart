import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:shopify/infrastructure/models/product.dart';
import 'package:shopify/presentation/widgets/circle_background_image.dart';
import 'package:shopify/presentation/widgets/custom_animated_icon.dart';

class ProductsDetails extends StatelessWidget {
  final Product product;
  final Color color;
  const ProductsDetails({Key? key, required this.product, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomAnimatedIcon(
                onTap: () {
                  provider.toggleFavorit(product);
                },
                color: Colors.red,
                icon: CupertinoIcons.heart_fill,
                isActive: product.isFavourite),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CircleBackgroundImage(
              color: color,
              image: product.image,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            child: Text(
                          product.title,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              '(${product.rating})',
                              style: TextStyle(color: Colors.black38),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      product.description,
                      style: TextStyle(color: Colors.green[400], fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              (product.price).toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  product.isInCart ? Colors.red : Colors.green),
                          onPressed: () {
                            provider.toggleCart(product);
                          },
                          icon: Icon(!product.isInCart
                              ? Icons.add_shopping_cart
                              : Icons.remove_shopping_cart),
                          label: Text(!product.isInCart
                              ? 'Add to cart'
                              : 'Remove from cart'),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
