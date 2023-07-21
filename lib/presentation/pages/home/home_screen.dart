import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.getComments(cancelToken: _cancelToken);
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => (previous.commentStatus != current.commentStatus),
        builder: (context, state) {
          if (state.commentStatus == LoadStatus.FAILURE) {
            return const Center(child: Text('Có lỗi xảy ra'));
          }
          if (state.commentStatus == LoadStatus.SUCCESS) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < state.listComment!.length; i++) ...[
                    Text('- ${state.listComment?[i].email} \n' ?? ''),
                  ]
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
