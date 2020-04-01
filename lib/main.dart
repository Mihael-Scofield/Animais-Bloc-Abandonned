import 'package:cat_app/bloc/ChoicePageBloc/ChoicePageBloc.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/view/ChoicePage/ChoicePageView.Dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animais são fofos',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: BlocProvider(
        create: (context) => ChoicePageBloc(), child: ChoicePage()),
    );
  }
}
