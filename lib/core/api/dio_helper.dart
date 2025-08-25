import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';


import '../../main.dart';
import '../../utils/app_constants.dart';
import '../cache/cache_helper.dart';
import 'data_source/end_point.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return (status ?? 0) < 500;
        },
        connectTimeout: const Duration(seconds: 200),
        receiveTimeout: const Duration(seconds: 200),
        sendTimeout: const Duration(seconds: 200),
      ),
    );

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // client.findProxy = (uri) => 'PROXY ${AppConstants.proxyUrl}:${AppConstants.proxyPort}';
        return client;
      },
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        compact: true,
        maxWidth: 120,
      ),
    );
  }

  // ========================================================
  // دالة موحدة لكل requests
  static Future<dynamic> _request(
      String method, {
        required String uri,
        dynamic data,
        Map<String, dynamic>? query,
      }) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());

    try {
      final response = await dio.request(
        uri,
        data: data,
        queryParameters: query,
        options: Options(method: method, headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode ?? 0;

        if (statusCode == 500) {
          throw Exception("Internal Server Error");
        } else {
          throw Exception("Error $statusCode: ${e.response?.statusMessage}");
        }
      } else {
        throw Exception("Network Error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  // ========================================================
  // GET
  static Future<dynamic> getData({
    required String uri,
    Map<String, dynamic>? query,
  }) async =>
      _request("GET", uri: uri, query: query);

  // POST
  static Future<dynamic> postData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
  }) async =>
      _request("POST", uri: uri, data: data, query: query);

  // PATCH
  static Future<dynamic> patchData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
  }) async =>
      _request("PATCH", uri: uri, data: data, query: query);

  // PUT
  static Future<dynamic> putData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
  }) async =>
      _request("PUT", uri: uri, data: data, query: query);

  // DELETE
  static Future<dynamic> deleteData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
  }) async =>
      _request("DELETE", uri: uri, data: data, query: query);

  // ========================================================

  static Future<void> _setInfo(String uri, [String query = ""]) async {
    dio.options.headers = await _getHeaders();
    // LoggerHelper.loggerNoStack.i('Api Call : ' + uri + "  |  " + query);
  }

  static Future<Map<String, dynamic>> _getHeaders() async {
    String? token = await CacheHelper.getData(key: AppConstants.token);

    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'language': langCode,
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    print("header is");
    print(headers);
    return headers;
  }
}
