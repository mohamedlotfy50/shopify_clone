import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopify/infrastructure/core/api_constants.dart';
import 'package:shopify/infrastructure/models/error_model.dart';
import 'package:shopify/infrastructure/models/http_respons.dart';

class HttpHelper {
  static Future<HttpResponse> getRequest(String url,
      {Map<String, String>? headers}) async {
    final http.Response response = await http
        .get(Uri.parse(ApiConstants.domainName + url), headers: headers);
    final res = json.decode(response.body);
    if (response.statusCode == 200) {
      return HttpResponse(null, res);
    }
    return HttpResponse(ErrorModel.fromJson(res), null);
  }

  static Future<HttpResponse> postRequest(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final http.Response response = await http.post(
        Uri.parse(ApiConstants.domainName + url),
        headers: headers,
        body: jsonEncode(body));
    final res = json.decode(response.body);
    if (response.statusCode == 200) {
      return HttpResponse(null, res);
    }
    return HttpResponse(ErrorModel.fromJson(res), null);
  }
}
