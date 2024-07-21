import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/core/hive/hive_services.dart';
import 'package:news_app_test/utils/my_theme.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HiveThemeWidget extends StatelessWidget {
  final Widget Function(BuildContext, Box<dynamic>, Widget?, String key)
      builder;
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

class HamzahNewsTitle extends StatelessWidget {
  const HamzahNewsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hamzah ",
          style: TextStyle(
            letterSpacing: -.5,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        GradientText("News",
            style: const TextStyle(
              letterSpacing: -.5,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            colors: MyTheme.gradientColors)
      ],
    );
  }
}

void showToast(String message, {Color? color}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    fontSize: 16.0,
  );
}
