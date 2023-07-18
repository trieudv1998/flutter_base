import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/resources/api_response.dart';
import 'package:flutter_base/core/resources/client_provider.dart';
import 'package:flutter_base/data/models/comment.dart';
import 'package:flutter_base/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl();

  @override
  Future<ApiResponse<List<CommentModel>>> getComments() async {
    try {
      final response = await RestClientProvider.apiClient!.getComments();

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      }

      return DataFailed(DioError(
        error: response.response.statusMessage,
        response: response.response,
        type: DioErrorType.response,
        requestOptions: response.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
