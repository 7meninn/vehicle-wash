import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient({
    required FlutterSecureStorage storage,
    String baseUrl = 'https://api.vehiclewash.mock',
  })  : _storage = storage,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
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

  // Mocked OTP logic since backend is not ready
  Future<Response> requestOtp(String mobileNumber) async {
    await Future.delayed(const Duration(seconds: 1));
    return Response(
      requestOptions: RequestOptions(path: '/auth/request-otp'),
      statusCode: 200,
      data: {'message': 'OTP sent successfully'},
    );
  }

  Future<Response> verifyOtp(String mobileNumber, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    if (otp == '123456') { // Mock logic
      return Response(
        requestOptions: RequestOptions(path: '/auth/verify-otp'),
        statusCode: 200,
        data: {
          'access_token': 'mock_access_token',
          'refresh_token': 'mock_refresh_token',
          'user': {'id': '1', 'role': 'customer'}
        },
      );
    } else {
      return Response(
        requestOptions: RequestOptions(path: '/auth/verify-otp'),
        statusCode: 400,
        data: {'message': 'Invalid OTP'},
      );
    }
  }

  Dio get dio => _dio;
}
