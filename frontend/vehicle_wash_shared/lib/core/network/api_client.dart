import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String _getBaseUrl() {
  if (kIsWeb) return 'http://localhost:8080/api/v1';
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/v1';
    }
    return 'http://localhost:8080/api/v1';
  }
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:8080/api/v1';
  }
  return 'http://localhost:8080/api/v1';
}

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient({
    required FlutterSecureStorage storage,
    String? baseUrl,
  })  : _storage = storage,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? _getBaseUrl(),
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // TODO: Token refresh logic
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> requestOtp(String mobileNumber) async {
    return _dio.post('/auth/request-otp', data: {'mobileNumber': mobileNumber});
  }

  Future<Response> verifyOtp(String mobileNumber, String otp) async {
    return _dio.post('/auth/verify-otp', data: {'mobileNumber': mobileNumber, 'otp': otp});
  }

  Dio get dio => _dio;
}
