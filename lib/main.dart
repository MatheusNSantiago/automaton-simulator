import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/application/mouse_cubit/mouse_cubit.dart';
import 'package:automata_simulator/presentation/canvas.dart';
import 'package:automata_simulator/presentation/menus/top/top_menus.dart';
import 'package:flutter/material.dart' hide Canvas;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/keyboard_cubit/keyboard_cubit.dart';
import 'constants.dart';
import 'injection.dart';
import 'presentation/menus/bottom/bottom_menus.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => KeyboardCubit()),
        BlocProvider(create: (_) => MouseCubit()),
        BlocProvider(create: (_) => getIt<CanvasCubit>()..readCanvas()),
      ],
      child: MaterialApp(
        title: 'Mochila de criança',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(onSurface: Colors.white),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        home: const Scaffold(
          backgroundColor: kSecondaryColor,
          body: Stack(
            children: [
              Canvas(),
              TopMenus(),
              BottomMenus(),
            ],
          ),
        ),
      ),
    );
  }
}
