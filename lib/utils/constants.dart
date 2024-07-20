import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/core/hive/hive_services.dart';

class HiveThemeWidget extends StatelessWidget {
  final Widget Function(BuildContext, Box<dynamic>, Widget?, String key) builder;
  const HiveThemeWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(HiveBoxes.settings.name).listenable(),
        builder: (context, box, widget) {
          return builder(context, box, widget, HiveBoxes.settings.key);
        });
  }
}
