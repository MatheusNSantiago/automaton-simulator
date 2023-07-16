import 'dart:math' hide Point;

import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransitionText extends StatefulWidget {
  final Link link;
  const TransitionText(this.link, {super.key});

  @override
  State<TransitionText> createState() => _TransitionTextState();
}

class _TransitionTextState extends State<TransitionText> {
  final double distance = -2.5;
  final double width = 30;
  final t = 0.475;
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.link.label ?? '';
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final angle = widget.link.path.getAngle(t);
    final angleDeg = angle * 180 / pi;

    var s = 1;
    /* Dependendo do quadrante em que o ângulo está, o offset precisa ser invertido */
    /* Não sei pq ficou esquisito assim, mas é a vida */
    if (angleDeg >= -90 && angleDeg < 0) s = 1; // 1º Quadrante
    if (angleDeg >= -180 && angleDeg <= -90) s = -1; // 2º Quadrante
    if (angleDeg > 90 && angleDeg <= 180) s = -1; // 3º Quadrante
    if (angleDeg >= 0 && angleDeg <= 90) s = 1; // 4º Quadrante

    /* Nos quadrantes 2 e 3 (onde s é -1), a axis do texto é invertida */
    var rotation = s == 1 ? angleDeg : angleDeg + 180;

    Point position = widget.link.path
        .getPoint(t)
        .translate(
          // Já esqueci o pq dessa equação, mas se expandir ela tu consegue entender
          dx: (width / 2) * (sin(angle) - cos(angle)) * s,
          dy: -(width / 2) * (sin(angle) + cos(angle)) * s,
        )
        .translate(
          dx: distance * sin(angle) * s,
          dy: -distance * cos(angle) * s,
        );

    final transform = Matrix4.identity()
      ..translate(position.x, position.y)
      ..rotateZ(rotation * pi / 180);

    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, _) {
          final canvas = context.read<CanvasCubit>();

          return Container(
            width: width,
            height: 35,
            transform: transform,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              cursorHeight: 20,
              maxLength: 1,
              onTap: () {
                // coloca o cursor no final do texto
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
                canvas.setSelectedLink(null);
              },
              onTapOutside: (_) {
                focusNode.unfocus(
                    disposition: UnfocusDisposition.previouslyFocusedChild);
                if (value.text.isNotEmpty) {
                  canvas.changeLinkLabel(widget.link, value.text);
                }
              },
              onSubmitted: (_) {
                canvas.changeLinkLabel(widget.link, value.text);
                focusNode.unfocus(
                    disposition: UnfocusDisposition.previouslyFocusedChild);
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counter: const SizedBox(),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                filled: true,
                errorText: value.text.isEmpty ? '' : null,
                errorStyle: const TextStyle(height: 0),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 1.25,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                color: Colors.white,
                height: 1.1,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.7),
                    offset: const Offset(0, 1),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
