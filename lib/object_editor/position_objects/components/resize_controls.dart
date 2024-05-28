import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class ResizeControlsComponent extends RectangleComponent
    with ParentIsA<PositionComponent>, HoverCallbacks, DragCallbacks {
  ResizeControlsComponent({
    required this.vertical,
  });

  final bool vertical;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    parent.size.addListener(_updateToParentSize);

    _updateToParentSize();
  }

  @override
  void onRemove() {
    super.onRemove();

    parent.size.removeListener(_updateToParentSize);
  }

  void _updateToParentSize() {
    if (vertical) {
      final width = parent.size.x * 0.1;
      size
        ..y = parent.size.y
        ..x = width;

      position
        ..y = 0
        ..x = parent.size.x - width;
    } else {
      final height = parent.size.y * 0.1;
      size
        ..x = parent.size.x
        ..y = height;

      position
        ..x = 0
        ..y = parent.size.y - height;
    }
  }

  void _setVisiblePaint() {
    paint = Paint()..color = const Color(0xAA000000);
  }

  void _setInvisiblePaint() {
    paint = Paint()..color = const Color(0x00000000);
  }

  void _setClickedPaint() {
    paint = Paint()..color = const Color(0x88000000);
  }

  @override
  void onHoverEnter() {
    super.onHoverEnter();

    _setVisiblePaint();
  }

  @override
  void onHoverExit() {
    super.onHoverExit();

    _setInvisiblePaint();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    _setClickedPaint();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    parent.size += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    _setVisiblePaint();
  }
}
