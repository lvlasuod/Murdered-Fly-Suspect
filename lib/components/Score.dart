// do the imports here

import 'dart:ui';

import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flame/anchor.dart';
import 'package:flame_game/MyGame.dart';
import 'package:flutter/material.dart';

class Score{
  int countOfKilledFlies=0;
  final MyGame game;
  bool isIncreased=false;
  Score(this.game){

  }
  void render(Canvas c) {
    // get center of screen x , y
    double screenCenterX = game.screenSize.width / 2;
    double screenCenterY = game.screenSize.height / 2;

    writeText(c, "Score: $countOfKilledFlies",
        Position(screenCenterX , screenCenterY -340), Colors.black);
  }
  void update(double t) {
    if(isIncreased){
      countOfKilledFlies++;
      isIncreased=false;
    }
  }

  void increaseScore(){
    isIncreased=true;
  }

  void writeText(Canvas canvas, String text, Position position, Color color) {
    TextConfig config = TextConfig(
        fontSize: 30.0,
        fontFamily: 'Awesome Font',
        textAlign: TextAlign.center,
        color: color);
    config.render(canvas, text, position, anchor: Anchor.topCenter);
  }
}