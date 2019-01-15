
class CollectionUtil {

  static bool isNullOrEmpty<E>(Iterable<E> collection) {
    return collection == null || collection.isEmpty;
  }

  static bool notNullOrEmpty<E>(Iterable<E> collection) {
    return !isNullOrEmpty(collection);
  }

}