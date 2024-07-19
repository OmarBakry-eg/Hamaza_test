import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(),
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
                  valueListenable: Hive.box('settings').listenable(),
                  builder: (context, box, widget) {
                    var isDarkMode = box.get('darkMode') ?? false;
                    return Switch(
                      value: isDarkMode,
                      onChanged: (value) async {
                        isDarkMode = value;
                        await box.put('darkMode', isDarkMode);
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

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return isDarkMode
            ? AppBar(
                title: const Text('Settings'),
              )
            : AppBar(
                title: const Text('Settings'),
              );
      },
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
