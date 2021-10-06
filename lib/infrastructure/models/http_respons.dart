import 'package:shopify/infrastructure/models/error_model.dart';

class HttpResponse {
  final ErrorModel? errorModel;
  final Map<String, dynamic>? json;
  final List? jsonList;

  HttpResponse._({
    required this.errorModel,
    required this.json,
    required this.jsonList,
  });
  factory HttpResponse(ErrorModel? errorModel, dynamic respons) {
    return HttpResponse._(
        errorModel: errorModel,
        json: respons is Map<String, dynamic> ? respons : null,
        jsonList: respons is List ? respons : null);
  }
  bool hasError() => errorModel != null && (json != null || jsonList != null);
}
