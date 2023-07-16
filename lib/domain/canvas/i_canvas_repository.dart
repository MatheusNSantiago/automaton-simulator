import 'canvas.dart';

abstract class ICanvasRepository {
  Future<void> saveCanvas(Canvas canvas);

  Future<Canvas> getCanvas();
}
