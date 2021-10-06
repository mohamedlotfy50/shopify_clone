import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopify/presentation/widgets/custom_animated_icon.dart';
import 'package:shopify/presentation/widgets/lable_price.dart';
import 'package:shopify/presentation/widgets/product_list_tile.dart';

class CartScreen extends StatelessWidget {
  final double tax = 40.00;
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (provider.deleteCartProducts) {
              provider.toggleDeleteIcon();
            } else {
              provider.cahngeCurrentPage(0);
            }
          },
        ),
        title: Text('My Cart'),
        actions: [
          if (provider.deleteCartProducts)
            TextButton(
                onPressed: () {
                  provider.selectaAll();
                },
                child: Text(
                  'Select All',
                  style: TextStyle(color: Colors.green),
                )),
          IconButton(
            onPressed: () {
              if (!provider.deleteCartProducts) {
                provider.toggleDeleteIcon();
              } else {
                provider.delete();
                provider.toggleDeleteIcon();
              }
            },
            icon: Icon(
              Icons.delete,
              color: provider.deleteCartProducts ? Colors.red : Colors.grey,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: ListView.builder(
                  itemCount: provider.cart.length,
                  itemBuilder: (context, index) {
                    return ProductListTile(
                      product: provider.cart[index],
                      isDeleteActive: provider.deleteCartProducts,
                      index: index,
                      trailing: !provider.deleteCartProducts
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAnimatedIcon(
                                    onTap: () {
                                      provider.decreaseQuantity(index);
                                    },
                                    isActive: false,
                                    icon: Icons.remove,
                                    color: Colors.red,
                                    isToggleable: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider.cart[index].quantity
                                        .toString()),
                                  ),
                                  CustomAnimatedIcon(
                                    onTap: () {
                                      provider.increaseQuantity(index);
                                    },
                                    icon: Icons.add,
                                    isActive: false,
                                    color: Colors.green,
                                    isToggleable: false,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LablePrice(
                    lable: 'Subtotal',
                    price: provider.getTotalPrice(),
                  ),
                  LablePrice(
                    lable: 'Tax',
                    price: tax,
                  ),
                ],
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
                        (provider.getTotalPrice() + tax).toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.creditcard),
                    label: Text('Check Out'),
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
            )
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
