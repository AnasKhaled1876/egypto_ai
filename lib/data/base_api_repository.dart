import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import '../core/data_state.dart';

class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == 200 ||
          httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data ?? {} as T);
      } else if (httpResponse.response.statusCode == 401) {
        throw DioException(
          error: httpResponse,
          requestOptions: httpResponse.response.requestOptions,
        );
      } else {
        if (runtimeType == SocketException) {
          httpResponse.response.statusCode = 503;
          throw DioException(
            error: httpResponse,
            requestOptions: httpResponse.response.requestOptions,
          );
        } else {
          throw DioException(
            error: httpResponse,
            requestOptions: httpResponse.response.requestOptions,
          );
        }
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
