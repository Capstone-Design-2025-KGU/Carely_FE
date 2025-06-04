import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DioMethod { post, get, put, delete, patch }

class APIService {
  APIService._singleton(this.baseUrl);

  static final APIService instance = APIService._createInstance();
  static final APIService aiInstance = APIService._createAiInstance();

  final String baseUrl;

  static APIService _createInstance() {
    final serverUrl = dotenv.get('SERVER_URL', fallback: '');
    if (serverUrl.isEmpty) {
      throw Exception('SERVER_URL is missing in .env');
    }
    return APIService._singleton(serverUrl);
  }

  static APIService _createAiInstance() {
    final aiUrl = dotenv.get('AI_URL', fallback: '');
    if (aiUrl.isEmpty) {
      throw Exception('AI_URL is missing in .env');
    }
    return APIService._singleton(aiUrl);
  }

  final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

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
    }
  }
}
