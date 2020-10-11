abstract class KeyValueStore {
  Future<List<String>> getStringList(String key);
  Future<bool> setStringList(String key, List<String> value);
}