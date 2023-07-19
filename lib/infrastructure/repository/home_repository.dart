

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/api_response.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';

abstract class HomeRepository {
  Future<ApiResponse<List<CommentModel>>> getComments();
}

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
