import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DioMethod { post, get, put, delete, patch }

class APIService {
  APIService._singleton();
  static final APIService instance = APIService._singleton();

  final serverURL = dotenv.env['SERVER_URL'] ?? 'http://10.0.2.2:8081';

  final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

  String get baseUrl {
    if (kDebugMode) {
      return '$serverURL/api';
    } else {
      return '$serverURL/api';
    }
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    FormData? formData,
    token,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.jsonContentType,
        headers: {if (token != null) HttpHeaders.authorizationHeader: '$token'},
      ),
    );

    dio.interceptors.add(logger);
    switch (method) {
      case DioMethod.post:
        return dio.post(endpoint, data: param ?? formData);
      case DioMethod.patch:
        return dio.patch(endpoint, data: param ?? formData);
      case DioMethod.get:
        return dio.get(endpoint, queryParameters: param);
      case DioMethod.put:
        return dio.put(endpoint, data: param ?? formData);
      case DioMethod.delete:
        return dio.delete(endpoint, data: param ?? formData);
      // ignore: unreachable_switch_default
      default:
        return dio.post(endpoint, data: param ?? formData);
    }
  }
}
