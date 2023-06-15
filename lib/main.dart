import 'package:flutter/material.dart';

import 'data/firestore/firestore_db.dart';
import 'data/mysql/mysql_db.dart';
import 'model/tarefa.dart';

void main() async {
  await (const FirestoreDb()).inicializa();
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Afazeres'),
        ),
        body: const Conteudo(),
      ),
    );
  }
}

class Conteudo extends StatefulWidget {
  const Conteudo({
    super.key,
  });

  @override
  State<Conteudo> createState() => _ConteudoState();
}

class _ConteudoState extends State<Conteudo> with TickerProviderStateMixin {
  List<Tarefa>? afazeres;

  @override
  void initState() {
    super.initState();
    atualizaAlunos();
  }

  void atualizaAlunos() {
    Tarefa.getAll().then((dados) {
      setState(() {
        afazeres = dados;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var listaUsuarios = afazeres == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: afazeres!.length,
            itemBuilder: (context, index) {
              final tarefa = afazeres!.elementAt(index);

              return Card(
                child: ListTile(
                  onTap: () async {
                    tarefa.completado = !tarefa.completado;
                    await tarefa.update();
                    setState(() {});
                  },
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      tarefa.delete().then((_) {
                        setState(() {
                          afazeres!.removeAt(index);
                        });
                      });
                    },
                  ),
                  title: Text(tarefa.titulo,
                      style: tarefa.completado
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough)
                          : const TextStyle()),
                ),
              );
            },
          );

    var controle = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: controle,
          decoration: const InputDecoration(
            labelText: 'Nova tarefa:',
          ),
          onSubmitted: (value) async {
            controle.text = '';
            var tarefa = Tarefa(value);
            tarefa = await tarefa.create();
            setState(() {
              afazeres?.add(tarefa);
            });
          },
        ),
        Expanded(
          child: listaUsuarios,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            onPressed: () {
              afazeres!
                  .where((element) => element.completado)
                  .forEach((element) async {
                await element.delete();
                setState(() {
                  afazeres!.remove(element);
                });
              });
            },
            // ignore: sort_child_properties_last
            child: const Icon(Icons.remove),
            tooltip: 'Apaga concluídos',
          ),
        ),
      ],
    );
  }
}
