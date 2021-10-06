import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:shopify/presentation/screens/cart_screen.dart';
import 'package:shopify/presentation/screens/favourite_screen.dart';
import 'package:shopify/presentation/screens/home_screen.dart';
import 'package:shopify/presentation/screens/splash_screen.dart';
import 'package:shopify/presentation/widgets/categories_bar.dart';
import 'package:shopify/presentation/widgets/product_card.dart';

class BottomNavigationScreen extends StatelessWidget {
  final List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
  ];
  BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider()..getAllCategories(),
      builder: (context, child) {
        final provider = context.watch<ProductsProvider>();
        return provider.isLoading
            ? SplashScreen()
            : Scaffold(
                body: pages[provider.currentPage],
                bottomNavigationBar: provider.currentPage == 0
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black12,
                                offset: Offset(0, -2),
                                spreadRadius: 3)
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          onTap: provider.cahngeCurrentPage,
                          currentIndex: provider.currentPage,
                          items: [
                            BottomNavigationBarItem(
                                icon: Icon(
                                  CupertinoIcons.home,
                                  size: 30,
                                ),
                                label: 'Home'),
                            BottomNavigationBarItem(
                                icon: Stack(
                                  children: [
                                    if (provider.cart.length > 0)
                                      Positioned(
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 9,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                              provider.cart.length.toString()),
                                        ),
                                      ),
                                    Icon(
                                      CupertinoIcons.cart,
                                      size: 30,
                                    )
                                  ],
                                ),
                                label: 'Cart'),
                            BottomNavigationBarItem(
                                icon: Stack(
                                  children: [
                                    if (provider.favourite.length > 0)
                                      Positioned(
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 9,
                                          backgroundColor: Colors.red,
                                          child: Text(provider.favourite.length
                                              .toString()),
                                        ),
                                      ),
                                    Icon(
                                      CupertinoIcons.heart,
                                      size: 30,
                                    )
                                  ],
                                ),
                                label: 'Favorite'),
                          ],
                        ),
                      )
                    : null,
              );
      },
    );
  }
}
