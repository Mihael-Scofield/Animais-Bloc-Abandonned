import 'package:cat_app/utils/FetchData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChoicePageEvent.dart';
import 'ChoicePageState.dart';

class ChoicePageBloc extends Bloc<ChoicePageEvent, ChoicePageState> {
  @override
  ChoicePageState get initialState => ChoicePageInitialState(); // Define o estado inicial

  // Mapeia todos os possíveis eventos e retorna o estado correto
  @override
  Stream<ChoicePageState> mapEventToState(event) async* {
    if (event is SettingAnimalsImagesEvent) {
      try {
        List<String> animalsImages;
        animalsImages = await setAnimalsImages();
        yield ChoicePageLoadedState(
          dogImage: animalsImages[0],
          catImage: animalsImages[1],
          foxImage: animalsImages[2]);
      }
      catch (exception) {
        yield ChoicePageErrorState(message: exception.toString()); // Retorna estado de erro
      } 
    }
  }

    // Seleciona as imagens dos animais
  Future<List<String>> setAnimalsImages() async {
    FetchData fetchData = new FetchData();
    List<String> animalsImages = List<String>();

    String newDogImageUrl = await fetchData.setDogImage();
    String newCatImageUrl = await fetchData.setCatImage();
    String newFoxImageUrl = await fetchData.setFoxImage();

    animalsImages.add(newDogImageUrl);
    animalsImages.add(newCatImageUrl);
    animalsImages.add(newFoxImageUrl);

    return animalsImages;
  }

}