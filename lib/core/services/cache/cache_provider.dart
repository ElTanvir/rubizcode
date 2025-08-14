import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/core/utils/utils.dart';

class CacheKeys {
  static const String boxName = 'eltanvir';
  static const String score = 'score';
}

/// A flexible caching service abstraction that allows seamless switching
/// between different local storage implementations
/// (Hive, SharedPreferences, etc.)
/// based on application requirements.

abstract class CacheService {
  Future<bool> save<T>(String key, T value);
  T? retrieve<T>(String key);
  Future<bool> delete(List<String> keys);
  Future<bool> clear();
  bool hasKey(String key);
  Future<void> dispose();
}

class HiveCacheService implements CacheService {
  HiveCacheService() {
    box = Hive.box(CacheKeys.boxName);
  }

  late Box<dynamic> box;

  @override
  Future<bool> save<T>(String key, T value) async {
    try {
      await box.put(key, value);
      return true;
    } catch (e) {
      Log.error('Error saving to cache: $e');
      return false;
    }
  }

  @override
  T? retrieve<T>(String key) {
    try {
      final value = box.get(key);
      if (value != null && value is T) {
        return value;
      }
      return null;
    } catch (e) {
      Log.error('Error retrieving from cache: $e');
      return null;
    }
  }

  @override
  Future<bool> delete(List<String> keys) async {
    try {
      await box.deleteAll(keys);
      return true;
    } catch (e) {
      Log.error('Error deleting from cache: $e');
      return false;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await box.clear();
      return true;
    } catch (e) {
      Log.error('Error clearing cache: $e');
      return false;
    }
  }

  @override
  bool hasKey(String key) {
    return box.containsKey(key);
  }

  @override
  Future<void> dispose() async {
    try {
      await box.deleteFromDisk();
    } catch (e) {
      Log.error('Error disposing cache: $e');
    }
  }
}
/// Provider for the cache service implementation.
/// 
/// To switch cache implementations (e.g., from Hive to SharedPreferences),
/// simply replace `HiveCacheService()` with your new implementation.
/// This change will automatically propagate throughout the entire app
/// via dependency injection, ensuring seamless storage backend switching.

final cacheServiceProvider = Provider(
  (ref) => HiveCacheService(),
);
