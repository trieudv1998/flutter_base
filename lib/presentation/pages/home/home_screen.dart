import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_base/presentation/routes/route_name.dart';
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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => (previous.commentStatus != current.commentStatus),
        builder: (context, state) {
          if (state.commentStatus == LoadStatus.FAILURE) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: Text(state.errorMessage ?? '')),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteName.login);
                      },
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.commentStatus == LoadStatus.SUCCESS) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 5; i++) ...[
                    Text('- ${state.listComment?[i].emailUser} \n' ?? ''),
                  ],
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteName.login);
                      },
                      child: const Text("Login"),
                    ),
                  ),
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
