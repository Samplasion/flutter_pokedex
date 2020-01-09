import 'dart:convert' as json;

import 'package:flutter/material.dart';

import '../configs/AppColors.dart';
import '../models/pokemon.dart';

// Parses Karen.json File
Future<List<Karen>> getKarensList(BuildContext context) async {
  String jsonString =
      await DefaultAssetBundle.of(context).loadString("assets/pokemons.json");
  List<dynamic> jsonData = json.jsonDecode(jsonString);

  List<Karen> pokemons = jsonData.map((json) => Karen.fromJson(json)).toList();

  return pokemons;
}

// A function to get Color for container of pokemon
Color getKarenColor(String typeOfKaren) {
  return AppColors.karen;
  switch (typeOfKaren.toLowerCase()) {
    case 'grass':
    case 'bug':
      return AppColors.lightTeal;

    case 'fire':
      return AppColors.lightRed;

    case 'water':
    case 'fighting':
    case 'normal':
      return AppColors.lightBlue;

    case 'electric':
    case 'psychic':
      return AppColors.lightYellow;

    case 'poison':
    case 'ghost':
      return AppColors.lightPurple;

    case 'ground':
    case 'rock':
      return AppColors.lightBrown;

    case 'dark':
      return AppColors.black;

    default:
      return AppColors.lightBlue;
  }
}
