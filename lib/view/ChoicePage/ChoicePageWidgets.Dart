import 'package:cat_app/bloc/ChoicePageBloc/ChoicePageState.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/view/AnimalPage.dart';

class ChoicePageWidgets {
  // Retorna a pagina de carregamento
  Widget buildLoading(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset('assets/loadingFox.gif',
                width: 170, height: 170, fit: BoxFit.cover),
          )),
        ),
        Text("Carregando...",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ));
  }

  // Constroi a tela carregada
  Widget buildChoicePage(
      String dogImage, catImage, foxImage, BuildContext context) {
    return SafeArea(
        child: Center(
            child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 25.0,
                runSpacing: 25.0,
                children: <Widget>[
          createInkWell('cachorro', dogImage, 'assets/loadingDog.gif', context),
          createInkWell('gato', catImage, 'assets/loadingCat.gif', context),
          createInkWell('raposa', foxImage, 'assets/loadingFox.gif', context)
        ])));
  }

  // Cria o InkWell, o card interativo com o animal passado
  InkWell createInkWell(
      String inkAnimal, animalImage, loadingAnimal, BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: animalImage != null
            ? FadeInImage(
                fadeInCurve: Curves.easeIn,
                fadeInDuration: Duration(milliseconds: 1000), // 1,5seg.
                image: NetworkImage(animalImage),
                placeholder: AssetImage(loadingAnimal),
                height: 170,
                width: 170,
                fit: BoxFit.cover)
            : Container(),
      ),
      onTap: () {
        navigateToAnimalPage(
            inkAnimal, context); // Navega de acordo com a chamada
      },
    );
  }

  // Faz a navegacao com o argumento do animal escolhido
  void navigateToAnimalPage(String chosenAnimal, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AnimalPage(chosenAnimal);
    }));
  }

  // Constroi a tela de erro
  Widget buildErrorUi(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset('assets/confusedDog.gif',
                  width: 170, height: 170, fit: BoxFit.cover),
            )),
          ),
          Text("Algo deu errado! o seguinte erro surgiu:",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, ChoicePageState state) {
    if (state is ChoicePageInitialState) {
      return buildLoading(context);
    } else if (state is ChoicePageLoadedState) {
      return buildChoicePage(
          state.dogImage, state.catImage, state.foxImage, context);
    } else if (state is ChoicePageErrorState) {
      return buildErrorUi(state.message);
    }

    return buildLoading(context);
  }
}
