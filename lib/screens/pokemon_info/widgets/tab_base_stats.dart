import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/AppColors.dart';
import '../../../models/pokemon.dart';
import '../../../widgets/progress.dart';

class Stat extends StatelessWidget {
  const Stat({
    Key key,
    @required this.animation,
    @required this.label,
    @required this.value,
    this.progress,
  }) : super(key: key);

  final Animation animation;
  final String label;
  final num value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final progress = this.progress == null ? this.value / 100 : this.progress;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * progress,
              color: progress < 0.5 ? AppColors.red : AppColors.teal,
            ),
          ),
        ),
      ],
    );
  }
}

class KarenBaseStats extends StatefulWidget {
  const KarenBaseStats({Key key}) : super(key: key);

  @override
  _KarenBaseStatsState createState() => _KarenBaseStatsState();
}

class _KarenBaseStatsState extends State<KarenBaseStats>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  List<Widget> generateStatWidget(Karen pokemon) {
    var id = (double.parse(pokemon.id.substring(2))) * 5;
    var hp = min(id * 2, 100);
    var atk = id * 1.7;
    var def = id * 1.8;
    var spa = id * 1.6;
    var sde = min(id * 1.9, 100);
    var spd = id * 1.2;
    var tot = hp + atk + def + spa + spd + spd;

    return [
      Stat(animation: _animation, label: "Hp", value: hp),
      SizedBox(height: 14),
      Stat(animation: _animation, label: "Atttack", value: atk),
      SizedBox(height: 14),
      Stat(animation: _animation, label: "Defense", value: def),
      SizedBox(height: 14),
      Stat(animation: _animation, label: "Sp. Atk", value: spa),
      SizedBox(height: 14),
      Stat(animation: _animation, label: "Sp. Def", value: sde),
      SizedBox(height: 14),
      Stat(animation: _animation, label: "Speed", value: spd),
      SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: "Total",
          value: tot,
          progress: tot / 600),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Consumer<KarenModel>(
        builder: (_, model, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ...generateStatWidget(model.pokemon),
            SizedBox(height: 27),
            Text(
              "Type defenses",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 0.8,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "The effectiveness of each type on ${model.pokemon.name}.",
              style: TextStyle(color: AppColors.black.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
