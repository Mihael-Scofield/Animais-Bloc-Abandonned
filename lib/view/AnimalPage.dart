import 'package:cat_app/utils/FetchData.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/model/Cats.dart';

class AnimalPage extends StatefulWidget {
  String chosenAnimal;

  AnimalPage(this.chosenAnimal);

  @override
  State<StatefulWidget> createState() {
    return AnimalPageState(this.chosenAnimal);
  }
}

class AnimalPageState extends State<AnimalPage> {
  // Titulo
  String chosenAnimal;
  AnimalPageState(this.chosenAnimal);
  String titlePage;

  // Scroll
  ScrollController _scrollController = new ScrollController();

  // Lista
  List<String> animalsImages = new List();
  CatList catList;
  String placeHolderAnimal;

  // Decide o titulo da pagina
  String decideTitlePage() {
    if (chosenAnimal == 'cachorro') {
      return "Cachorros amam abanar o rabo";
    } else {
      if (chosenAnimal == 'gato') {
        return "Gatos amam morder os donos";
      } else {
        return "Que som que a raposa faz?";
      }
    }
  }

  // Adiciona na lista um novo animal
  void addAnimalImage(String newAnimalUrl) {
    animalsImages.add(newAnimalUrl);
  }

  // Puxa uma imagem de animal
  void getAnimalImage() async {
    FetchData fetchData = new FetchData();
    if (chosenAnimal == 'cachorro') {
      String newDogImage = await fetchData.setDogImage();
      setState(() {
        addAnimalImage(newDogImage);
      });
    } else {
      if (chosenAnimal == 'gato') {
        String newCatImage = await fetchData.setCatImage();
        setState(() {
          addAnimalImage(newCatImage);
        });
      } else {
        String newFoxImage = await fetchData.setFoxImage();
        setState(() {
          addAnimalImage(newFoxImage);
        });
      }
    }
  }

  // Puxa oito imagens diferentes
  void fetchEight() {
    for (int i = 0; i < 8; i++) {
      getAnimalImage();
    }
  }

  // Retorna o animal utilizado como Place Holder
  String setPlaceHolderImage() {
    if (chosenAnimal == 'cachorro') {
      return 'assets/loadingDog.gif';
    } else {
      if (chosenAnimal == 'gato') {
        return 'assets/loadingCat.gif';
      } else {
        return 'assets/loadingFox.gif';
      }
    }
  }

  @override

  // Estado inicial da pagina
  void initState() {
    super.initState();

    titlePage = decideTitlePage();
    placeHolderAnimal = setPlaceHolderImage();
    fetchEight();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchEight();
      }
    });
  }

  GridView createGridView() {
    return GridView.builder(
        controller: _scrollController,
        itemCount: animalsImages.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: animalsImages[index] != null
                    ? FadeInImage(
                        fadeInCurve: Curves.easeIn,
                        fadeInDuration: Duration(milliseconds: 1500),
                        image: NetworkImage(animalsImages[index]),
                        placeholder: AssetImage(placeHolderAnimal),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover)
                    : Container()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titlePage),
        ),
        body: createGridView());
  }
}
