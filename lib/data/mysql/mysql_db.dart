import "package:mysql_client/mysql_client.dart";

import "../../model/tarefa.dart";
import "../mysql/mysql_tarefa.dart";
import "../db.dart";

class MySQLDb extends Db {
  const MySQLDb();

  Future<IResultSet> query(String sql, [Map<String, dynamic>? params]) async {
    MySQLConnection conexao = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'flutter',
      password: 'senha123',
      databaseName: 'flutter_db',
      secure: false,
    );

    await conexao.connect();
    var result = await conexao.execute(sql, params);
    await conexao.close();

    return result;
  }

  @override
  Future<void> inicializa() async {
    Tarefa.repos = const MySqlTarefa();
  }
}
