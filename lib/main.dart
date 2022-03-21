import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_app_test/cubit/characters_cubit.dart';
import 'package:valorant_app_test/repository/http_repositories.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersCubit>(
          create: (context) => CharactersCubit(charactersRepository),
        ),
      ],
      child: MaterialApp(
          title: 'Valorant',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white10,
          ),

          // home: const MyHomePage(title: 'Valorar geis'),
          debugShowCheckedModeBanner: false,
          home: const Home()),
    );
  }
}