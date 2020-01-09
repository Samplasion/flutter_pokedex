import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../data/pokemons.dart';
import '../../models/pokemon.dart';
import '../../widgets/fab.dart';
import '../../widgets/poke_container.dart';
import '../../widgets/pokemon_card.dart';
import 'widgets/generation_modal.dart';
import 'widgets/search_modal.dart';

class KarenDex extends StatefulWidget {
  const KarenDex();

  @override
  _KarenDexState createState() => _KarenDexState();
}

class _KarenDexState extends State<KarenDex>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    KarenModel pokemonModel = KarenModel.of(context, listen: true);

    if (!pokemonModel.hasData) {
      getKarensList(context).then(pokemonModel.setKarens);
    }

    super.didChangeDependencies();
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomModal(),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GenerationModal(),
    );
  }

  Widget _buildOverlayBackground() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return IgnorePointer(
          ignoring: _animation.value == 0,
          child: InkWell(
            onTap: () => _animationController.reverse(),
            child: Container(
              color: Colors.black.withOpacity(_animation.value * 0.5),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PokeContainer(
            appBar: true,
            children: <Widget>[
              SizedBox(height: 34),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  "KarenDex",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 32),
              Consumer<KarenModel>(
                builder: (context, pokemonModel, child) => Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
                    itemCount: pokemonModel.pokemons.length,
                    itemBuilder: (context, index) => KarenCard(
                      pokemonModel.pokemons[index],
                      index: index,
                      onPress: () {
                        pokemonModel.setSelectedIndex(index);
                        Navigator.of(context).pushNamed("/pokemon-info");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildOverlayBackground(),
        ],
      ),
    );
  }
}
