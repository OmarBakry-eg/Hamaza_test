import 'package:flutter/material.dart';
import 'package:news_app_test/app.dart';
import 'package:news_app_test/di.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  await di.init();
  runApp(const MyApp());
}
