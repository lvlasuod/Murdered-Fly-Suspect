import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game/MyGame.dart';

class Fly {
  final MyGame game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  Sprite flySprite;
  Fly(this.game, double x, double y) {
    flySprite = Sprite('flies/hungry-fly-1.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
   // flyPaint = Paint();
   // flyPaint.color = Color(0xff6ab04c);
  }
  void render(Canvas c) {
    //c.drawRect(flyRect, bgSprite);
    flySprite.renderRect(c,flyRect);
  }
  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
  }
  void onTapDown() {
    isDead = true;
   // flyPaint.color = Color(0xffff4757);
    flySprite = Sprite('flies/agile-fly-dead.png');
    game.spawnFly();
  }
}