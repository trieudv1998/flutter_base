
import 'package:flutter_base/core/enum/storage_keys.dart';

abstract class SharedPreferencesService {
  Future<void> setStringValue(StorageKeys key, String value);

  Future<String> getStringValue(StorageKeys key);

  Future<void> setIntValue(StorageKeys key, int value);

  Future<int?> getIntValue(StorageKeys key);

  Future<void> removeByKey(StorageKeys key);
}
