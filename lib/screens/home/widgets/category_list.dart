import 'package:flutter/cupertino.dart';

import '../../../data/categories.dart';
import '../../../widgets/poke_category_card.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.66,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
      itemCount: 1,
      itemBuilder: (context, index) => PokeCategoryCard(
        categories[index],
        onPress: () => Navigator.of(context).pushNamed("/pokedex"),
      ),
    );
  }
}
