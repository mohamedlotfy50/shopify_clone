import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopify/presentation/widgets/custom_animated_icon.dart';
import 'package:shopify/presentation/widgets/product_list_tile.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            provider.cahngeCurrentPage(0);
          },
        ),
        title: Text('My Favourites'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: ListView.builder(
                  itemCount: provider.favourite.length,
                  itemBuilder: (context, index) {
                    return ProductListTile(
                      product: provider.favourite[index],
                      isDeleteActive: false,
                      index: index,
                      trailing: CustomAnimatedIcon(
                          onTap: () {
                            provider.toggleFavorit(provider.favourite[index]);
                          },
                          color: Colors.red,
                          icon: CupertinoIcons.heart_fill,
                          isActive: true),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFFEAEAEA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
