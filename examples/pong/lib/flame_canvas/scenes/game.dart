// GENERATED CODE - DO NOT MODIFY MANUALLY
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class $Game extends FlameGame {
  $Game();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final paddle = $Paddle(
      position: Vector2(
        -266.49531249999995,
        -35.27734375,
      ),
    );
    world.add(paddle);
    final ball = $Ball(
      position: Vector2(
        -1.0460937499999545,
        -124.21484375,
      ),
    );
    world.add(ball);
  }
}
