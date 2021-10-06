import 'package:flutter/material.dart';
import 'package:shopify/application/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopify/presentation/screens/product_details.dart';
import 'package:shopify/presentation/screens/splash_screen.dart';
import 'package:shopify/presentation/widgets/categories_bar.dart';
import 'package:shopify/presentation/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
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

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        leading: IconButton(
          onPressed: () {},
          icon: RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.bar_chart_rounded),
          ),
        ),
        title: Text(
          'Shopify',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Our Products',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          CategoriesBar(),
          Expanded(
            child: Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  provider.getAllCategories();
                },
                child: GridView.builder(
                  itemCount: provider.prod.length,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: size.aspectRatio * 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: ProductsDetails(
                                color: getBackgroundColor(index),
                                product: provider.prod[index],
                              ),
                            ),
                          ),
                        );
                      },
                      index: index,
                      product: provider.prod[index],
                      color: getBackgroundColor(index),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
