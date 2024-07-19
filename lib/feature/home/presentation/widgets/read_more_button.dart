import 'package:flutter/material.dart';
import 'package:news_app_test/utils/my_theme.dart';

class HelperButton extends StatelessWidget {
  final Function onTap;
  final String? title;
  const HelperButton(
      {super.key, required this.onTap, this.title = 'Read more'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 36,
        width: 129.62,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: MyTheme.gradientColors,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title!,
            style: MyTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
