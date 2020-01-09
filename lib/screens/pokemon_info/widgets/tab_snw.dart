import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/AppColors.dart';
import '../../../models/pokemon.dart';

class KarenStrengthsAndWeaknesses extends StatelessWidget {
  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        SizedBox(height: 21),
        Divider(),
        SizedBox(height: 21),
      ],
    );
  }

  List<Widget> buildList(List<String> data) {
    return data
        .map((String strength) => Text(strength))
        .expand((w) => [w, _buildDivider()])
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
              "Strengths",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
            ),
            SizedBox(height: 28),
            ...buildList(model.pokemon.strengths).toList(),
            Text(
              "Weaknesses",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
            ),
            SizedBox(height: 28),
            ...buildList(model.pokemon.weaknesses).toList(),
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
