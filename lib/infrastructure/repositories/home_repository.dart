import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/application/repositories/home_repository.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

class HomeRepository extends IHomeRepository {
  HomeRepository();

  @override
  Future<Either<ErrorModel, List<CommentModel>>> getComments({CancelToken? cancelToken}) async {
    try {
      // TODO: implement getComments
      final response = await RestClientProvider.apiClient!.getComments(cancelToken);

      //TODO: handler response models => entity
      return Right(response);
    } on DioError catch (e) {
      return Left(ErrorModel(message: e.error.toString()));
    }
  }
}
