import 'package:flutter/cupertino.dart';
import 'package:shopify/infrastructure/core/api_constants.dart';
import 'package:shopify/infrastructure/helper/http_helper.dart';
import 'package:shopify/infrastructure/helper/pre_helper.dart';
import 'package:shopify/infrastructure/models/categories.dart';
import 'package:shopify/infrastructure/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  int currentPage = 0;
  int currentcategory = 0;
  bool deleteCartProducts = false;
  late Categories categories;
  PrefHelper _prefHelper = PrefHelper();
  bool isLoading = true;
  Map<String, List<Product>> categoryProducts = {
    'All': <Product>[],
  };
  List<Product> prod = [];
  List<Product> favourite = [];
  List<Product> cart = [];
  List<Product> deleteList = [];

  List<String> categoriesList() => categoryProducts.keys.toList();
  void getCurrentCategoryProducts(int index) {
    prod = categoryProducts[categoriesList()[index]]!;
  }

  double getTotalPrice() {
    double total = 0;
    cart.forEach((element) {
      total += element.price;
    });
    return total;
  }

  void cahngeCurrentPage(int page) {
    currentPage = page;

    notifyListeners();
  }

  void toggleFavorit(Product p) {
    if (favourite.contains(
      p,
    )) {
      for (int i = 0; i < prod.length; i++) {
        if (p == prod[i]) {
          favourite.remove(p);
          prod[i].isFavourite = false;
          break;
        }
      }
    } else {
      favourite.add(p);
      prod.forEach((element) {
        if (p == element) {
          element.isFavourite = true;
        }
      });
    }
    storeFavouriteChange();
    notifyListeners();
  }

  void toggleCart(Product p) {
    if (cart.contains(
      p,
    )) {
      for (int i = 0; i < prod.length; i++) {
        if (p == prod[i]) {
          cart.remove(p);
          prod[i].isInCart = false;
          break;
        }
      }
    } else {
      cart.add(p);
      prod.forEach((element) {
        if (p == element) {
          element.isInCart = true;
        }
      });
    }
    storeCartChange();

    notifyListeners();
  }

  void increaseQuantity(int index) {
    cart[index].quantity = cart[index].quantity + 1;
    storeCartChange();

    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity > 1) {
      cart[index].quantity = cart[index].quantity - 1;
      storeCartChange();
    }
    notifyListeners();
  }

  void cahngeCurrentcategory(int index) {
    currentcategory = index;
    getCurrentCategoryProducts(index);

    notifyListeners();
  }

  void toggleDeleteIcon() {
    deleteCartProducts = !deleteCartProducts;
    deleteList.clear();
    notifyListeners();
  }

  Future getAllCategories() async {
    isLoading = true;
    notifyListeners();
    final res = await HttpHelper.getRequest(ApiConstants.category);
    categories = Categories.fromJson(res.jsonList!);
    categories.category.forEach((element) {
      categoryProducts[element] = <Product>[];
    });
    cart = await _prefHelper.getProduct('cart');
    favourite = await _prefHelper.getProduct('favourite');
    final productRespons =
        await HttpHelper.getRequest(ApiConstants.allProducts);
    List<Product> prodcts = Product.fromJsonList(productRespons.jsonList!);
    prodcts.forEach((element) {
      List<Product> all = categoryProducts['All']!;
      List<Product> cat = categoryProducts[element.category]!;
      if (favourite.contains(element)) {
        element..isFavourite = true;
      }
      if (cart.contains(element)) {
        element..isInCart = true;
      }
      all.add(element);
      cat.add(element);
      categoryProducts['All'] = all;
      categoryProducts[element.category] = cat;
    });
    getCurrentCategoryProducts(currentPage);
    isLoading = false;
    notifyListeners();
  }

  void storeCartChange() async {
    await _prefHelper.addProduct('cart', cart);
  }

  void storeFavouriteChange() async {
    await _prefHelper.addProduct('favourite', favourite);
  }

  void selectaAll() {
    cart.forEach((element) {
      deleteList.add(element);
    });
    notifyListeners();
  }

  void delete() {
    deleteList.forEach((element) {
      prod[prod.indexOf(element)].isInCart = false;
      cart.remove(element);
    });
    storeCartChange();
    notifyListeners();
  }

  void togeleDelete(Product p) {
    if (deleteList.contains(p)) {
      deleteList.remove(p);
    } else {
      deleteList.add(p);
    }
    notifyListeners();
  }
}
