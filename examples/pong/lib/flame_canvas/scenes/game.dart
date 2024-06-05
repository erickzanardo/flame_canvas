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
        -280.00703124999995,
        -127.546875,
      ),
    );
    world.add(paddle);
    final paddle1 = $Paddle(
      position: Vector2(
        251.58671875000005,
        -118.921875,
      ),
    );
    world.add(paddle1);
    final ball = $Ball(
      position: Vector2(
        -4.5968749999999545,
        -85.01171875,
      ),
    );
    world.add(ball);
    final paddle2 = $Paddle(
      position: Vector2(
        -42.549999999999955,
        127.70703125,
      ),
    );
    world.add(paddle2);
    final paddle3 = $Paddle(
      position: Vector2(
        73.74296875000005,
        -219.67578125,
      ),
    );
    world.add(paddle3);
    final paddle4 = $Paddle(
      position: Vector2(
        -86.33124999999995,
        -245.703125,
      ),
    );
    world.add(paddle4);
    final paddle5 = $Paddle(
      position: Vector2(
        -71.66093750000002,
        16.8046875,
      ),
    );
    world.add(paddle5);
    final paddle6 = $Paddle(
      position: Vector2(
        89.00703124999998,
        18.4140625,
      ),
    );
    world.add(paddle6);
  }
}
