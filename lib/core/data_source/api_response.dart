import 'package:dio/dio.dart';

abstract class ApiResponse<T> {
  final T? data;
  final DioError? error;

  const ApiResponse({this.data, this.error});
}

class DataSuccess<T> extends ApiResponse<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends ApiResponse<T> {
  const DataFailed(DioError error) : super(error: error);
}
