import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

enum HiveBoxes {
  settings("darkMode"),
  cachedNews("cachedNewsKey");

  final String key;
  const HiveBoxes(this.key);
}

abstract class HiveService<T> {
  final String boxName;

  const HiveService(this.boxName);

  static Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PopularNewsResultAdapter());
    await Hive.openBox(HiveBoxes.settings.name);
    await Hive.openBox(HiveBoxes.cachedNews.name);
  }

  Future<Box> _openBox() async {
    return Hive.isBoxOpen(boxName)
        ? Hive.box(boxName)
        : await Hive.openBox<T>(boxName);
  }

  Future<void> addItem(String key, T item) async {
    final box = await _openBox();
    await box.put(key, item);
  }

  Future<dynamic> getItem(String key) async {
    final box = await _openBox();
    return box.get(key);
  }

  Future<void> deleteItem(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  Future<void> clearBox() async {
    final box = await _openBox();
    await box.clear();
  }
}
