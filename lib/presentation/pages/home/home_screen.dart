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

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.getComments();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => (previous.commentStatus != current.commentStatus),
        builder: (context, state) {
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
