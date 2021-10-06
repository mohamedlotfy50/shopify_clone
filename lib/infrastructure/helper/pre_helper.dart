import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/infrastructure/models/product.dart';

class PrefHelper {
  SharedPreferences? _sharedPreferences;

  Future _init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  Future isExist(String key) async {
    await _init();

    if (_sharedPreferences!.containsKey(key)) {
      return true;
    }
    return false;
  }

  Future addString(String key, String value) async {
    await _init();
    await _sharedPreferences!.setString(key, value);
  }

  Future addProduct(String key, List<Product> value) async {
    await _init();
    List<String> list = [];
    value.forEach((element) {
      list.add(json.encode(element.toJson()));
    });

    await _sharedPreferences!.setStringList(key, list);
  }

  Future<List<Product>> getProduct(String key) async {
    await _init();
    List<Product> list = [];
    List<String>? db = _sharedPreferences!.getStringList(key);
    db?.forEach((element) {
      list.add(Product.fromJson(json.decode(element)));
    });

    return list;
  }
}
