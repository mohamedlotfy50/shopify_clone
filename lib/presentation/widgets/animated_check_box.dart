import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:shopify/infrastructure/models/product.dart';

class AnimatedCheckBox extends StatelessWidget {
  final bool isActive;
  final Product product;
  const AnimatedCheckBox({
    Key? key,
    required this.isActive,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.togeleDelete(product);
      },
      child: AnimatedContainer(
        padding: EdgeInsets.all(8),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: provider.deleteList.contains(product)
              ? Colors.green
              : Colors.transparent,
          border: provider.deleteList.contains(product)
              ? null
              : Border.all(color: Colors.white, width: 3),
          shape: BoxShape.circle,
        ),
        width: isActive ? 50 : 0,
        child: provider.deleteList.contains(product)
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : Container(
                height: 24,
                width: 24,
              ),
      ),
    );
  }
}
