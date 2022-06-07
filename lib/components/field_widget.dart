import 'package:campo_minado/models/field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  FieldWidget({
    Key key,
    @required this.field,
    @required this.onOpen,
    @required this.onSwitchMarked,
  }) : super(key: key);

  Field field;
  Function(Field) onOpen;
  Function(Field) onSwitchMarked;

  Widget _getImage() {
    int amnMines = field.amountMinesOnNeighbourhood;
    if (field.opened && field.mined && field.blownUp) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.opened && field.mined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.opened && amnMines > 0) {
      return Image.asset('assets/images/aberto_$amnMines.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onSwitchMarked(field),
      child: _getImage(),
    );
  }
}
