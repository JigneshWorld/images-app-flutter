import 'package:images_app/domain/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared preference based key-value store implementation
class SharedPrefKeyValueStore extends KeyValueStore {
  @override
  Future<List<String>> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }
}
