import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

import '../../model/tarefa.dart';
import '../repository.dart';

class FirestoreTarefa extends Repositorio<Tarefa> {
  CollectionReference getColecao() {
    var firestore = Firestore.instance;
    var caminho = '/afazeres/${FirebaseAuth.instance.userId}/lista';
    var collection = firestore.collection(caminho);
    return collection;
  }

  @override
  Future<Tarefa> create(Tarefa item) async {
    var doc = await getColecao().add(item.toMap());
    var map = doc.map;
    map['id'] = doc.id;

    return Tarefa.fromMap(map);
  }

  @override
  Future<void> delete(Tarefa item) async {
    await getColecao().document(item.id).delete();
  }

  @override
  Future<List<Tarefa>> getAll() async {
    var colecao = await getColecao().get();
    var tarefaMap = colecao.map((element) {
      var map = element.map;
      map['id'] = element.id;
      return Tarefa.fromMap(map);
    });
    return tarefaMap.toList();
  }

  @override
  Future<void> update(Tarefa item) async {
    await getColecao()
        .document(
          item.id,
        )
        .update(
          item.toMap(),
        );
  }
}
