import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:
            // TODO(erickzanardo): Change to an initial page that will allow
            // project loading
            BlocProvider(
          create: (_) => EditorCubit(),
          child: const EditorPage(),
        ),
      ),
    );
  }
}
