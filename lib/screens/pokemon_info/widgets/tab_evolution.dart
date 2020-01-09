import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/AppColors.dart';
import '../../../models/pokemon.dart';

class KarenBall extends StatelessWidget {
  const KarenBall(this.pokemon, {Key key}) : super(key: key);

  final Karen pokemon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final pokeballSize = screenHeight * 0.1;
    final pokemonSize = pokeballSize * 0.85;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/pokeball.png",
              width: pokeballSize,
              height: pokeballSize,
              color: AppColors.lightGrey,
            ),
          ],
        ),
        SizedBox(height: 3),
        Text(
          pokemon.name,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class KarenEvolution extends StatelessWidget {
  Widget _buildRow({current: Karen, next: Karen, reason: String}) {
    return Row(
      children: <Widget>[
        Expanded(child: KarenBall(current)),
        Expanded(
          child: Column(
            children: <Widget>[
              Icon(Icons.arrow_forward, color: AppColors.lightGrey),
              SizedBox(height: 7),
              Text(
                reason,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(child: KarenBall(next)),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        SizedBox(height: 21),
        Divider(),
        SizedBox(height: 21),
      ],
    );
  }

  List<Widget> buildEvolutionList(List<Karen> pokemons) {
    if (pokemons.length == 0)
      return [
        Center(child: Text("No evolution")),
      ];

    return Iterable<int>.generate(pokemons.length - 1) // skip the last one
        .map(
          (index) => _buildRow(
              current: pokemons[index],
              next: pokemons[index + 1],
              reason: "evolves in"),
        )
        .expand((widget) => [widget, _buildDivider()])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cardController = Provider.of<AnimationController>(context);

    return AnimatedBuilder(
      animation: cardController,
      child: Consumer<KarenModel>(
        builder: (_, model, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Evolution Chain",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
            ),
            SizedBox(height: 28),
            ...buildEvolutionList(model.pokemons
                .getRange(model.pokemons.indexOf(model.pokemon),
                    model.pokemons.length)
                .toList()),
          ],
        ),
      ),
      builder: (context, widget) {
        final scrollable = cardController.value.floor() == 1;

        return SingleChildScrollView(
          physics: scrollable
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 31, horizontal: 28),
          child: widget,
        );
      },
    );
  }
}
