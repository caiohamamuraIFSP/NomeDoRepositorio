abstract class Repositorio<T> {
  const Repositorio();
  Future<List<T>> getAll();
  Future<void> delete(T item);
  Future<void> update(T item);
  Future<T> create(T item);
}
