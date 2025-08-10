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
  static Future<dynamic> getData({required String uri, Map<String, dynamic>? query}) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());
    return (await dio.get(
      uri,
      queryParameters: query,
      options: Options(headers: headers),
    ))
        .data;
  }

  static Future<dynamic> postData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());
    return (await dio.post(
      uri,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    ))
        .data;
  }

  static Future<dynamic> patchData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());
    return (await dio.patch(
      uri,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    ))
        .data;
  }

  static Future<dynamic> putData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());
    return (await dio.put(
      uri,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    ))
        .data;
  }

  static Future<dynamic> deleteData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    final headers = await _getHeaders();
    _setInfo(uri, query.toString());
    return (await dio.delete(
      uri,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    ))
        .data;
  }


  // ========================================================

  static Future<void> _setInfo(String uri, [String query = ""]) async {
    dio.options.headers = await _getHeaders();
    // LoggerHelper.loggerNoStack.i('Api Call : ' + uri + "  |  " + query);
  }


  // static Map<String, dynamic> _getHeaders() {
  //   String? token = CacheHelper.getData(key: "token");
  //   Map<String, dynamic> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   headers['Authorization'] = 'Bearer $token';
  //   // String lang = navigatorKey.currentContext?.locale.languageCode.toLowerCase() ?? 'en';
  //   headers['locale'] = CacheHelper.getData(key: "lang");
  //   return headers;
  // }
  static Future<Map<String, dynamic>> _getHeaders() async {
    String? token = await CacheHelper.getData(key: AppConstants.token);

    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // if (lang != null) {
    //   headers['language'] = lang;
    // }
    // if (lang != null) {
      headers['language'] = langCode;
    // }
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }


    print("header  is");
    print(headers);
    return headers;
  }

}
