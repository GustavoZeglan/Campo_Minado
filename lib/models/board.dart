import 'dart:math';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/foundation.dart';

class Board {
  final int lines;
  final int pillars;
  final int amountBombs;
  final List<Field> _fields = [];

  Board({
    @required this.lines,
    @required this.pillars,
    @required this.amountBombs,
  }) {
    _createFields();
    _connectNeighbours();
    _drawMines();
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int p = 0; p < pillars; p++) {
        _fields.add(Field(line: l, pillar: p));
      }
    }
  }

  void _connectNeighbours() {
    for (var field in _fields) {
      for (var neighbour in _fields) {
        field.addNeigbours(neighbour);
      }
    }
  }

  void restart() {
    _fields.forEach((f) => f.restart());
    _drawMines();
  }

  void revealBombs() {
    _fields.forEach((f) => f.revealsBomb());
  }

  void _drawMines() {
    int draw = 0;

    if (amountBombs > lines * pillars) {
      return;
    }

    while (draw < amountBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        draw++;
        _fields[i].mine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((f) => f.resolved);
  }
}
