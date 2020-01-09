import 'package:flutter/cupertino.dart';

import '../../models/pokemon.dart';

class KarenInfoArguments extends ChangeNotifier {
  KarenInfoArguments({this.index, this.pokemons});

  int index;
  final List<Karen> pokemons;

  void setIndex(int changedIndex) {
    index = changedIndex;
    notifyListeners();
  }
}
