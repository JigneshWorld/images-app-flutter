/// key-value data store interface
abstract class KeyValueStore {
  /// retrieve stored list of string for specified key. default: null
  Future<List<String>> getStringList(String key);

  /// save list of strings for specified key
  Future<bool> setStringList(String key, List<String> value);
}
