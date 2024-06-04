import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/home/home.dart';
import 'package:flame_canvas/l10n/l10n.dart';
import 'package:flame_canvas/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ProjectRepository()),
      ],
      child: BlocProvider(
        create: (context) => AppCubit(
          projectRepository: context.read(),
        ),
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeView(),
        ),
      ),
    );
  }
}
