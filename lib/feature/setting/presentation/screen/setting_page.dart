import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/core/hive/hive_services.dart';
import 'package:news_app_test/utils/extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Interface',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Use dark mode',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Get that whiteness out',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box(HiveBoxes.settings.name).listenable(),
                  builder: (context, box, widget) {
                    bool? isDarkMode = box.get(HiveBoxes.settings.key);
                    return Switch(
                      value: isDarkMode ??
                          context.deviceBrightnessMode == Brightness.dark,
                      onChanged: (value) async {
                        isDarkMode = value;
                        await box.put(HiveBoxes.settings.key, isDarkMode);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
