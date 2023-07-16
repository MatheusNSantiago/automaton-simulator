import 'dart:convert';
import 'dart:io';

import 'package:automata_simulator/domain/canvas/canvas.dart';
import 'package:automata_simulator/domain/canvas/i_canvas_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICanvasRepository)
class CanvasRepository implements ICanvasRepository {
  @override
  Future<Canvas> getCanvas() async {
    final json = await File('automata.json').readAsString();
    final decoded = jsonDecode(json);

    return Canvas.fromJson(decoded);
  }

  @override
  Future<void> saveCanvas(Canvas canvas) async {
    final file = await File('automata.json').create();
    await file.writeAsString(jsonEncode(canvas.toJson()));
  }
}
