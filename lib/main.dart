import 'package:flutter/material.dart';
import 'package:news_app_test/app.dart';
import 'package:news_app_test/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
