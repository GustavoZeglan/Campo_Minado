import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/components/result_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/field.dart';
import '../models/explosion_exception.dart';
import 'package:flutter/material.dart';

class MinedFieldPage extends StatefulWidget {
  const MinedFieldPage({Key key}) : super(key: key);

  @override
  State<MinedFieldPage> createState() => _MinedFieldPageState();
}

class _MinedFieldPageState extends State<MinedFieldPage> {
  @override
  Widget build(BuildContext context) {
    bool _win;

    Board _board = Board(
      lines: 12,
      pillars: 12,
      amountBombs: 3,
    );

    void _restart() {
      _board.restart();
      _win = null;
    }

    void _open(Field field) {
      if (_win != null) {
        return;
      }

      setState(() {
        try {
          field.open();
          if (_board.resolved) {
            _win = true;
          }
        } on ExplosionException {
          _win = false;
          _board.revealBombs();
        }
      });
    }

    void _switchMarked(Field field) {
      if (_win != null) {
        return;
      }
      setState(() {
        field.switchMarked();
        if (_board.resolved) {
          _win = true;
        }
      });
    }

    Board _getBoard(double widget, double height) {
      if (_board != null) {
        int amnPillars = 15;
        double fieldSize = widget / amnPillars;
        int amnlines = (height / fieldSize).floor();

        _board = Board(
          lines: amnlines,
          pillars: amnPillars,
          amountBombs: 30,
        );
      }
      return _board;
    }

    return Scaffold(
      appBar: ResultWidget(
        win: _win,
        onRestart: () => _restart,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BoardWidget(
            board: _getBoard(constraints.maxWidth, constraints.maxHeight),
            onOpen: _open,
            onSwitchMarked: _switchMarked,
          );
        },
      ),
    );
  }
}
