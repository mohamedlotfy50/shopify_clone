import 'package:flutter/cupertino.dart';
import 'package:shopify/infrastructure/core/api_constants.dart';
import 'package:shopify/infrastructure/helper/http_helper.dart';
import 'package:shopify/infrastructure/helper/pre_helper.dart';
import 'package:shopify/infrastructure/models/http_respons.dart';
import 'package:shopify/infrastructure/models/login.dart';

class AuthProvider extends ChangeNotifier {
  PrefHelper _prefHelper = PrefHelper();
  String _userName = '';
  String _password = '';
  bool isloading = false;
  late Login l;
  void printValues() {
    print('username is $_userName');
    print('password is $_password');
  }

  void onPasswordChanged(String? value) {
    _password = value!;
  }

  void onUserNameChanged(String? value) {
    _userName = value!;
  }

  void checkLoginUser(Function() navigate) async {
    final isexist = await _prefHelper.isExist('user');
    if (isexist) {
      navigate();
    }
    print(isexist);
  }

  Future login() async {
    isloading = true;
    notifyListeners();
    final HttpResponse response = await HttpHelper.postRequest(
      ApiConstants.login,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {'username': _userName, 'password': _password},
    );
    l = Login.fromJson(response.json!);
    await _prefHelper.addString('user', l.token);

    isloading = false;
    notifyListeners();
  }
}
