import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState({this.data, this.error});
  final T? data;
  final DioException? error;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

String errorMessage(DioException exception) {
  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.sendTimeout ||
      exception.type == DioExceptionType.connectionError) {
    return "Check Your Internet Connection";
  } else if (exception.type == DioExceptionType.badResponse) {
    return exception.response?.data?["message"] ?? "Something Went Wrong";
  } else if (exception.type == DioExceptionType.cancel) {
    return "Request Canceled";
  } else if (exception.type == DioExceptionType.unknown) {
    return "Check Your Internet Connection";
  } else {
    return "Something Went Wrong";
  }
}
