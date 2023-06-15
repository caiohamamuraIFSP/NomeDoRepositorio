import 'package:p01_msql_example/data/repository.dart';

class Tarefa {
  static late Repositorio<Tarefa> repos;
  String id;
  String titulo;
  bool completado;

  Tarefa(this.titulo, {this.id = '', this.completado = false});

  Tarefa.fromMap(Map<String, dynamic> map)
      : id = map['id'].toString(),
        titulo = map['titulo'],
        completado = map['completado'];

  Map<String, Object> toMap() => {
        'titulo': titulo,
        'completado': completado,
      };

  static Future<List<Tarefa>> getAll() async {
    return await repos.getAll();
  }

  Future<Tarefa> create() async {
    return await repos.create(this);
  }

  Future<void> update() async {
    return await repos.update(this);
  }

  Future<void> delete() async {
    return await repos.delete(this);
  }
}
