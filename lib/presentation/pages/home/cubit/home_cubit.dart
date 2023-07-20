import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/infrastructure/repository/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(const HomeState());

  Future<void> getComments() async {
    emit(state.copyWith(commentStatus: LoadStatus.LOADING));
    try {
      final response = await homeRepository.getComments();
      response.fold(
          (l) => {
                emit(state.copyWith(commentStatus: LoadStatus.FAILURE)),
              },
          (r) => {
                emit(state.copyWith(
                  commentStatus: LoadStatus.SUCCESS,
                  listComment: r,
                )),
              });
    } catch (e, s) {
      emit(state.copyWith(commentStatus: LoadStatus.FAILURE));
    }
  }
}
