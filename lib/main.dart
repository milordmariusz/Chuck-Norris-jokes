import 'package:chuck_norris_jokes_api/title_screen/bloc/title_screen_bloc.dart';
import 'package:chuck_norris_jokes_api/title_screen/title_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chuck Norris jokes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
        create: (BuildContext context) => TitleScreenBloc(),
        child: TitleScreenPage()));
  }
}
