import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/application/products_provider.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider provider = Provider.of<ProductsProvider>(context);
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shrinkWrap: true,
        itemCount: provider.categoriesList().length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _CategoryCard(
            onPressed: () {
              provider.cahngeCurrentcategory(index);
            },
            text: provider.categoriesList()[index],
            isSelected: provider.currentcategory == index,
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onPressed;
  const _CategoryCard(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        margin: EdgeInsets.only(left: 15),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              if (isSelected)
                BoxShadow(
                    color: Colors.green.withAlpha(100),
                    blurRadius: 0.5,
                    offset: Offset(4, 4),
                    spreadRadius: 0.3)
            ]),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.green,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 18),
        ),
      ),
    );
  }
}
