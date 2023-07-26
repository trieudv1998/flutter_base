import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/application/repositories/home_repository.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';
import 'package:flutter_base/core/domain/utils/logger.dart';
import 'package:flutter_base/infrastructure/entities/comment.dart';
import 'package:flutter_base/infrastructure/repositories/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(const HomeState());

  Future<void> getComments({CancelToken? cancelToken}) async {
    emit(state.copyWith(commentStatus: LoadStatus.LOADING));
    try {
      Either<ErrorModel, List<CommentModel>> response = await homeRepository.getComments(cancelToken: cancelToken);
      response.fold(
        (error) => {
          emit(state.copyWith(
            commentStatus: LoadStatus.FAILURE,
            errorMessage: error.message,
          )),
          AppLogger.instance.error(error.message),
        },
        (response) => {
          emit(state.copyWith(
            commentStatus: LoadStatus.SUCCESS,
            listComment: response.map((e) => e.toEntity()).toList(),
          )),
        },
      );
    } catch (e, s) {
      emit(state.copyWith(
        commentStatus: LoadStatus.FAILURE,
        errorMessage: e.toString(),
      ));
      AppLogger.instance.error(e);
    }
  }
}
