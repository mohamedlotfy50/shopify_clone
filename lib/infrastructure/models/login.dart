import 'package:shopify/infrastructure/models/error_model.dart';

class Login {
  final String token;
  final ErrorModel error;

  Login({
    required this.token,
    required this.error,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['token'] ?? '',
      error: ErrorModel.fromJson(json),
    );
  }
}
