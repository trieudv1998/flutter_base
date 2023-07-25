import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/data_sources/interfaces/home_datasource.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<List<CommentModel>> getComments({CancelToken? cancelToken}) async {
    // TODO: implement getComments
    final response = await RestClientProvider.apiClient!.getComments(cancelToken);
    return response;
  }
}
