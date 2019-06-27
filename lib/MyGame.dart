import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flame/game.dart';
import 'package:flame/anchor.dart';
import 'package:flame_game/components/Score.dart';
import 'package:flame_game/components/fly.dart';
import 'package:flutter/material.dart';

import 'components/Backyard.dart';

class MyGame extends Game {
  Size screenSize;
  double tileSize;
  Backyard background;
  List<Fly> flies;
  Random rnd;
  Score score;
  int countOfKilledFlies;
  MyGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    score=Score(this);
    resize(await Flame.util.initialDimensions());
    countOfKilledFlies=0;
    background = Backyard(this);
     spawnFly();
  }
  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    flies.add(Fly(this, x, y));
  }
  @override
  void render(Canvas canvas) {
    // draw background
    background.render(canvas);

    score.render(canvas);

    flies.forEach((Fly fly) => fly.render(canvas));
//    // get center of screen x , y
//    double screenCenterX = screenSize.width / 2;
//    double screenCenterY = screenSize.height / 2;
//
//      writeText(canvas, "Score: $countOfKilledFlies",
//          Position(screenCenterX , screenCenterY ), Colors.white);

  }

  @override
  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    score.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }
  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        score.increaseScore();
        print(score.countOfKilledFlies);
        fly.onTapDown();
      }
    });
  }
//  void writeText(Canvas canvas, String text, Position position, Color color) {
//    TextConfig config = TextConfig(
//        fontSize: 48.0,
//        fontFamily: 'Awesome Font',
//        textAlign: TextAlign.center,
//        color: color);
//    String text = "LUX TEXAS HOLDEM POKER";
//    config.render(canvas, "Score: 0", position, anchor: Anchor.center);
  //}
}
