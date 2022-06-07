import 'package:campo_minado/models/explosion_exception.dart';
import 'package:flutter/foundation.dart';

class Field {
  final int line;
  final int pillar;
  final List<Field> neighbours = [];

  bool _opened = false;
  bool _marked = false;
  bool _mined = false;
  bool _blownUp = false;

  Field({
    @required this.line,
    @required this.pillar,
  });

  void addNeigbours(Field neighbour) {
    final deltaLine = (line - neighbour.line).abs();
    final deltaPillar = (pillar - neighbour.pillar).abs();

    if (deltaLine == 0 && deltaPillar == 0) {
      return;
    }
    if (deltaLine <= 1 && deltaPillar <= 1) {
      neighbours.add(neighbour);
    }
  }

  void open() {
    if (_opened) {
      return;
    }

    _opened = true;

    if (_mined) {
      _blownUp = true;
      throw ExplosionException();
    }

    if (safeNeighbourhood) {
      neighbours.forEach((n) {
        n.open();
      });
    }
  }

  void revealsBomb() {
    if (mined) {
      _opened = true;
    }
  }

  void mine() {
    _mined = true;
  }

  void switchMarked() {
    _marked != _marked;
  }

  void restart() {
    _opened = false;
    _marked = false;
    _mined = false;
    _blownUp = false;
  }

  bool get mined {
    return _mined;
  }

  bool get opened {
    return _opened;
  }

  bool get blownUp {
    return _blownUp;
  }

  bool get marked {
    return _marked;
  }

  bool get resolved {
    bool minedAndMarked = mined && marked;
    bool safeAndOpened = !mined && opened;
    return minedAndMarked || safeAndOpened;
  }

  int get amountMinesOnNeighbourhood {
    return neighbours.where((n) => n.mined).length;
  }

  bool get safeNeighbourhood {
    return neighbours.every((n) => !n.mined);
  }
}
