import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/domain/model/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlPoint extends StatefulWidget {
  final Link link;

  const ControlPoint({
    super.key,
    required this.link,
  });

  @override
  State<ControlPoint> createState() => _ControlPointState();
}

class _ControlPointState extends State<ControlPoint> {
  /// Usado para escolher o cursor enquanto arrasta o CP
  ///
  /// quando é verdadeiro, o [size] do container aumenta porque, quando movimentamos o CP, por
  /// ele ser muito pequeno, ao movimentar rapidamente, o [MouseRegion] laga um pouco para detectar
  /// que que ainda está dando hover no CP. Ao aumentar o tamanho de contato, acabei com esse problema
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final canvas = context.read<CanvasCubit>();
    final size = _isDragging? 40.0: 10.0;

    return Positioned.fromRect(
      rect: Rect.fromCenter(
        center: widget.link.cp.toOffset(),
        width: size,
        height: size,
      ),
      child: MouseRegion(
        cursor: _isDragging? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
        child: GestureDetector(
          onPanStart: (details) => canvas.clearMarquee(),
          onPanUpdate: (details) {
            setState(() => _isDragging = true);
            canvas.translateControlPoint(widget.link, details.delta);
          },
          onPanEnd: (details) => setState(() => _isDragging = false),
          child: Container(
            margin: EdgeInsets.all(_isDragging ? 20: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
