import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

enum HiveBoxes {
  settings("darkMode"),
  cachedNews("cachedNewsKey");

  final String key;
  const HiveBoxes(this.key);
}

abstract class HiveService<T> {
  final HiveBoxes hiveBox;

  const HiveService(this.hiveBox);

  static Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PopularNewsResultAdapter());
    for (var e in HiveBoxes.values) {
      await Hive.openBox(e.name);
    }
  }

  Future<Box> _openBox() async {
    return Hive.isBoxOpen(hiveBox.name)
        ? Hive.box(hiveBox.name)
        : await Hive.openBox<T>(hiveBox.name);
  }

  Future<void> addItem(T item) async {
    final box = await _openBox();
    await box.put(hiveBox.key, item);
  }

  Future<dynamic> getItem() async {
    final box = await _openBox();
    return box.get(hiveBox.key);
  }

  Future<void> deleteItem() async {
    final box = await _openBox();
    await box.delete(hiveBox.key);
  }

  Future<void> clearBox() async {
    final box = await _openBox();
    await box.clear();
  }
}
