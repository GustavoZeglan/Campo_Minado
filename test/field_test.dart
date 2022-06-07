import 'package:campo_minado/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Field', () {
    test("Abrir campo COM explosão", () {
      Field f = Field(line: 0, pillar: 0);
      f.mine();

      expect(f.open, throwsException);
    });
    test("Abrir campo SEM explosão", () {
      Field f = Field(line: 0, pillar: 0);
      f.open();

      expect(f.opened, isTrue);
    });
    test("Adicionar NÂO vizinho", () {
      Field f1 = Field(line: 0, pillar: 0);
      Field f2 = Field(line: 1, pillar: 3);
      f1.addNeigbours(f2);
      expect(f1.neighbours.isEmpty, isTrue);
    });
    test("Adicionar vizinho", () {
      Field f1 = Field(line: 3, pillar: 3);
      Field f2 = Field(line: 3, pillar: 4);
      Field f3 = Field(line: 2, pillar: 2);
      Field f4 = Field(line: 4, pillar: 4);
      f1.addNeigbours(f2);
      f1.addNeigbours(f3);
      f1.addNeigbours(f4);
      expect(f1.neighbours.length, 3);
    });
    test("Minas na vizinhança", () {
      Field f1 = Field(line: 3, pillar: 3);
      Field f2 = Field(line: 3, pillar: 4);
      f2.mine();
      Field f3 = Field(line: 2, pillar: 2);
      Field f4 = Field(line: 4, pillar: 4);
      f4.mine();
      f1.addNeigbours(f2);
      f1.addNeigbours(f3);
      f1.addNeigbours(f4);
      expect(f1.amountMinesOnNeighbourhood, 2);
    });
  });
}
