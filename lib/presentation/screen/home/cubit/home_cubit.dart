import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/enum/load_status.dart';
import 'package:flutter_base/core/repositories/home_repository.dart';
import 'package:flutter_base/di.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final  homeRepository = getIt<HomeRepository>();
}
