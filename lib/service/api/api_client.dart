import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient {
  var appBaseUrl;
  static const String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 30;

  late Map<String, String> _mainHeaders;

  ApiClient({this.appBaseUrl}) {
    updateHeader();
  }

  void updateHeader({bool? multipart}) async {
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      Uri fullUri = Uri.parse(appBaseUrl + uri).replace(queryParameters: query);
      if (kDebugMode) {
        debugPrint('====> API Base url: $appBaseUrl');
        debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .get(fullUri, headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(noInternetMessage, 0);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    Response response0;
    try {
      response0 = Response(response.body, response.statusCode);
    } catch (_) {
      body = jsonDecode(response.body);
      response0 = Response(
        jsonEncode(body ?? response.body),
        response.statusCode,
      );
    }
    if (response0.statusCode != 200 && response0.statusCode != 201) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        response0 = Response(
          json.decode(response0.body)["message"] ?? '',
          response0.statusCode,
        );
      } else if (response0.statusCode == 401) {
        try {
          response0 = Response(
            json.decode(response0.body)["message"],
            response0.statusCode,
          );
        } catch (_) {}
      } else {
        try {
          response0 = Response(body["message"], response0.statusCode);
        } catch (_) {
          response0 = Response(
            jsonDecode(response.body)['message'],
            response0.statusCode,
          );
        }
      }
    } else if (response0.statusCode != 200 &&
        response0.statusCode != 201 &&
        response0.body == null) {
      response0 = Response(noInternetMessage, 0);
    }
    if (kDebugMode) {
      debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}',
      );
    }
    return response0;
  }
}
