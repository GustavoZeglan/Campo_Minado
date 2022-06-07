import 'package:campo_minado/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Ganhar Jogo', () {
    Board board = Board(
      lines: 2,
      pillars: 2,
      amountBombs: 0,
    );

    board.fields[0].mine();
    board.fields[3].mine();

    board.fields[0].switchMarked();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].switchMarked();
  });
}
