// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:p01_msql_example/data/firestore/firestore_db.dart';
import 'package:p01_msql_example/model/tarefa.dart';

void main() async {
  setUpAll(() async {
    await const FirestoreDb().inicializa();
  });
  test('Testa pega todas as tarefas', () async {
    var tarefas = await Tarefa.getAll();
    for (var element in tarefas) {
      print(
          'id: ${element.id}, titulo: ${element.titulo}, completado: ${element.completado}');
    }
  });

  test('Cria tarefas', () async {
    var tarefa = Tarefa('Teste123');
    tarefa = await tarefa.create();
    print(tarefa.id);

    var tarefa2 = Tarefa('Teste456');
    tarefa2 = await tarefa2.create();
    print(tarefa2.id);
  });
}
