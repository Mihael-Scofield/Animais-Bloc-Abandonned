import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChoicePageState extends Equatable {}

// Estado inicial do Bloc
class ChoicePageInitialState extends ChoicePageState {
  @override
  List<Object> get props => [];
}

// Estado de imagens carregadas
class ChoicePageLoadedState extends ChoicePageState {
  String dogImage, catImage, foxImage;

  ChoicePageLoadedState({@required this.dogImage, @required this.catImage, @required this.foxImage});

  @override
  List<Object> get props => [dogImage, catImage, foxImage];
}

// Estado de erro no carregamento das imagens
class ChoicePageErrorState extends ChoicePageState {
  String message;

  ChoicePageErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}