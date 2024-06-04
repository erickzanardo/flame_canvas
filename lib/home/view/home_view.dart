import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
    void initState() {
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AppCubit>().loadProject('../examples/pong');
      });
    }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.of(context).push(EditorPage.route());
        }
      },
      child: const Scaffold(body: CircularProgressIndicator()),
    );
  }
}
