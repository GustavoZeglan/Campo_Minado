import 'package:campo_minado/components/field_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onSwitchMarked;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onSwitchMarked,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: board.pillars,
      children: board.fields.map((f) {
        return FieldWidget(
          field: f,
          onOpen: onOpen,
          onSwitchMarked: onSwitchMarked,
        );
      }).toList(),
    );
  }
}
