
import 'package:flutter/material.dart';

extension DarkMode on BuildContext {

  Brightness get deviceBrightnessMode {
    final brightness = MediaQuery.platformBrightnessOf(this);
    return brightness;
  }
  
}