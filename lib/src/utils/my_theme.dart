import 'package:flutter/material.dart';

class MyTheme {
  static List<Color> gradientColors = const [
    Color(0XFFFF2E00),
    Color(0XFFC714D7),
    Color.fromARGB(255, 121, 76, 167)
  ];

  static TextStyle displayLarge = const TextStyle(
      letterSpacing: -.5, fontSize: 38, fontWeight: FontWeight.w600);

  static TextStyle labelLarge = const TextStyle(
      letterSpacing: -.5, fontSize: 32, fontWeight: FontWeight.w700);
  static const TextStyle labelMedium =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w700);

  static const TextStyle labelSmall =
      TextStyle(letterSpacing: -.1, fontSize: 15, fontWeight: FontWeight.w500);

  static const TextStyle displaySmall = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 1.25,
      letterSpacing: .2);

  static const TextStyle displayMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1,
    overflow: TextOverflow.ellipsis,
  );
}
