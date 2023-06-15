import "package:firedart/firedart.dart";
import "package:path_provider/path_provider.dart";

import '../db.dart';

class FirestoreDb extends Db {
  const FirestoreDb();

  @override
  Future<void> inicializa() async {
    const apiKey = 'CHAVE_MUITO_GRANDE';
    const projectCode = 'todolist-123abc';
    const user = 'teste@flutter.br';
    const password = 'senha123';
    final documentsPath = (await getApplicationDocumentsDirectory()).path;

    FirebaseAuth.initialize(apiKey, VolatileStore());
    if (FirebaseAuth.instance.isSignedIn == false) {
      await FirebaseAuth.instance.signIn(user, password);
    }
    Firestore.initialize(projectCode);
  }
}
