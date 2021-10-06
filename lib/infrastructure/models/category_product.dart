import 'package:shopify/infrastructure/models/product.dart';

class CategoryProduct {
  final List<Product> products;
  CategoryProduct({required this.products});
  factory CategoryProduct.fromJson(List json) {
    return CategoryProduct(products: Product.fromJsonList(json));
  }
}
