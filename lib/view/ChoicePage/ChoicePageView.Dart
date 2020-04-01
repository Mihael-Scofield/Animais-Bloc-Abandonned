import 'package:cat_app/bloc/ChoicePageBloc/ChoicePageBloc.dart';
import 'package:cat_app/bloc/ChoicePageBloc/ChoicePageEvent.dart';
import 'package:cat_app/bloc/ChoicePageBloc/ChoicePageState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/view/ChoicePage/ChoicePageWidgets.Dart';

class ChoicePage extends StatefulWidget {
  @override
    _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  ChoicePageBloc choicePageBloc;

  @override
  // Estado inicial da pagina
  void initState() {
    super.initState();

    choicePageBloc = BlocProvider.of<ChoicePageBloc>(context); // Amarracao do Bloc com o contexto do app
    choicePageBloc.add(SettingAnimalsImagesEvent()); // Adiciona evento inicial ao bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Escolha um animal para apreciar'),
        ),
    body: Builder(  
        builder: (context) {
          return Material(
            child: Scaffold(
              body: Container(
                child: BlocBuilder<ChoicePageBloc, ChoicePageState>(
                  bloc: choicePageBloc,
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 700),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(child: child, scale: animation,);
                      },
                      child: ChoicePageWidgets().buildPage(context, state)
                      );
                  },
                ),
              ),
          ));
        },
      ));
  }
}