import '../../data/repository.dart';
import '../../model/tarefa.dart';
import 'mysql_db.dart';

class MySqlTarefa extends Repositorio<Tarefa> {
  const MySqlTarefa();

  @override
  Future<List<Tarefa>> getAll() async {
    var db = const MySQLDb();

    var results = await db.query('SELECT * FROM tarefas');

    return results.rows
        .map(
          (row) => Tarefa.fromMap(
            row.typedAssoc(),
          ),
        )
        .toList();
  }

  @override
  Future<void> delete(Tarefa item) async {
    var db = const MySQLDb();
    await db.query('DELETE FROM tarefas WHERE id = :id', {'id': item.id});
  }

  @override
  Future<Tarefa> create(Tarefa item) async {
    var db = const MySQLDb();
    var result = await db.query(
      '''
        INSERT INTO tarefas (titulo, completado)
        VALUES (:titulo, :completado)
      ''',
      {
        'titulo': item.titulo,
        'completado': item.completado,
      },
    );
    item.id = result.lastInsertID.toString();
    return item;
  }

  @override
  Future<void> update(Tarefa item) async {
    var db = const MySQLDb();
    await db.query(
      '''
        UPDATE tarefas 
        SET
          titulo = :titulo,
          completado = :completado
        WHERE id = :id
      ''',
      {
        'titulo': item.titulo,
        'completado': item.completado,
        'id': item.id,
      },
    );
  }
}
