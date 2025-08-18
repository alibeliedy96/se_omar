// this method for only this project
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mr_omar/utils/app_constants.dart';
import '../../../common/common.dart';
import '../../../main.dart';

import '../dio_helper.dart';
import '../error/error_handler/error_handler.dart';
import '../error/error_handler/failure.dart';

// ==================== other ====================
Color get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];

void unFocusKeyboard() => FocusScope.of(navigatorKey.currentContext!).requestFocus(FocusNode());

// ==================== dio ====================

Failure? _handleServerError(Map<String, dynamic> responseJson) {
  // ✅ check status
  if (responseJson.containsKey("status")) {
    final status = responseJson["status"];
    print("status code is $status");
    if (status != 200 && status != 201) {
      return Failure(
        status ?? -1,
        responseJson['message'] ?? "",
        TypeMsg.error,
      );
    }
  }

  // ✅ check success
  if (responseJson.containsKey("success")) {
    final success = responseJson["success"];
    if (success is bool && success == false) {
      return Failure(
        responseJson["status"] ?? -1,
        responseJson['message'] ?? "Something went wrong",
        TypeMsg.error,
      );
    }
  }

  return null; // no error
}

enum DioMethod { post, get, delete, put, patch }

Future<Either<Failure, T>> handleResponse<T>({
  required String endPoint,
  dynamic data,
  DioMethod method = DioMethod.get,
  required T Function(Map<String, dynamic> map) asObject,
  Map<String, dynamic>? query,
  int? page,
  bool handleServerError = true,
}) async {
  try {
    query ??= {};
    if (page != null) query[AppConstants.paginationQuery] = page;

    Map<String, dynamic> json = {};
    if (method == DioMethod.get) {
      json = await DioHelper.getData(uri: endPoint, query: query);
    }
    if (method == DioMethod.post) {
      json = await DioHelper.postData(uri: endPoint, data: data, query: query);
    }
    if (method == DioMethod.put) {
      json = await DioHelper.putData(uri: endPoint, data: data, query: query);
    }
    if (method == DioMethod.delete) {
      json = await DioHelper.deleteData(uri: endPoint, data: data, query: query);
    }
    if (method == DioMethod.patch) {
      json = await DioHelper.patchData(uri: endPoint, data: data, query: query);
    }

    print("json is");
    print(json);

    final failure = _handleServerError(json);
    if (failure != null) {
      return left(failure);
    }

    return right(asObject(json));
  } catch (e, s) {
    if (kDebugMode) {
      print("ERROR IN handleResponse : $e \n\n$s");
    }
    return left(ErrorHandlerCustom.handle(e).failure);
  }
}
