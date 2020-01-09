import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/pokemons.dart';

class Karen {
  const Karen({
    @required this.id,
    this.name,
    this.about,
    this.types = const ["Karen"],
    this.strengths,
    this.weaknesses,
  });

  Karen.fromJson(dynamic json)
      : id = json["id"],
        name = json["name"],
        about = json["description"],
        types = json["typeofpokemon"].cast<String>(),
        strengths = json["strengths"].cast<String>(),
        weaknesses = json["weaknesses"].cast<String>();

  final String about;
  final String id;
  final String name;
  final List<String> types;
  final List<String> strengths;
  final List<String> weaknesses;

  Color get color => getKarenColor(types[0]);
}

class KarenModel extends ChangeNotifier {
  final List<Karen> _pokemons = [];
  int _selectedIndex = 0;

  UnmodifiableListView<Karen> get pokemons => UnmodifiableListView(_pokemons);

  bool get hasData => _pokemons.length > 0;

  Karen get pokemon => _pokemons[_selectedIndex];

  int get index => _selectedIndex;

  static KarenModel of(BuildContext context, {bool listen = false}) =>
      Provider.of<KarenModel>(context, listen: listen);

  void setKarens(List<Karen> pokemons) {
    _pokemons.clear();
    _pokemons.addAll(pokemons);

    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;

    notifyListeners();
  }
}
