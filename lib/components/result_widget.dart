import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  const ResultWidget({
    @required this.win,
    @required this.onRestart,
  });

  final bool win;
  final Function onRestart;

  @override
  Widget build(BuildContext context) {
    Color _getCor() {
      if (win == null) {
        return Colors.yellow;
      } else if (win) {
        return Colors.green[300];
      } else {
        return Colors.red[300];
      }
    }

    IconData _getIcon() {
      if (win == null) {
        return Icons.sentiment_satisfied;
      } else if (win) {
        return Icons.sentiment_very_satisfied;
      } else {
        return Icons.sentiment_dissatisfied;
      }
    }

    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onRestart,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
