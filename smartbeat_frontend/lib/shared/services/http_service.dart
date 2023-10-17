import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';
import 'package:smartbeat_frontend/shared/utils/logger.dart';

class HttpService {
  static final HttpService _instance = HttpService._privateConstructor();

  HttpService._privateConstructor();

  static HttpService get instance => _instance;

  static final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static Map<String, String> get headers => _defaultHeaders;

  void setToken(String token) {
    _defaultHeaders.putIfAbsent('Authorization', () => 'Bearer $token');
  }

  void clearToken() {
    _defaultHeaders.remove('Authorization');
  }

  Future<dynamic> post(
    String path, {
    Object? body,
  }) async {
    if (Environment.entorno != Entorno.prod) {
      Logger.info('HttpRequest Url: $path con ${body ?? '{}'}');
    }

    await Future.delayed(const Duration(seconds: 2));

    try {
      Uri url = Uri.parse(path);
      http.Response response = await http.post(
        url,
        headers: _defaultHeaders,
        body: json.encode(body),
      );
      dynamic responseMap = _decodeResponse(response);
      _validateResponse(response.statusCode, responseMap);
      Logger.info('HttpResponse: $responseMap');
      return responseMap;
    } on ServiceException catch (e) {
      Logger.error('Error ServiceException en $path: $e');
      throw ServiceException(message: e.message);
    }
  }

  Future<dynamic> get(String path) async {
    if (Environment.entorno != Entorno.prod) {
      Logger.info('HttpRequest Url: $path');
    }

    await Future.delayed(const Duration(seconds: 2));

    try {
      Uri url = Uri.parse(path);
      http.Response response = await http.get(
        url,
        headers: _defaultHeaders,
      );

      dynamic responseMap = _decodeResponse(response);
      _validateResponse(response.statusCode, responseMap);
      Logger.info('HttpResponse: $responseMap');
      return responseMap;
    } on ServiceException catch (e) {
      Logger.error('Error ServiceException en $path: $e');
      throw ServiceException(message: e.message);
    }
  }

  dynamic _decodeResponse(http.Response response) {
    String responseBody = utf8.decode(response.bodyBytes);
    try {
      return jsonDecode(responseBody);
    } catch (_) {
      return responseBody;
    }
  }

  void _validateResponse(int statusCode, dynamic responseMap) {
    if (responseMap is Map<String, dynamic> &&
        responseMap.containsKey("success") &&
        !responseMap["success"]) {
      throw ServiceException(message: responseMap["message"]);
    }
  }
}
