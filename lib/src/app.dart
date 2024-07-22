import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/src/feature/home/presentation/screens/home.dart';
import 'package:news_app_test/src/feature/login/presentation/cubit/auth_cubit.dart';
import 'package:news_app_test/src/utils/constants.dart';
import 'package:news_app_test/src/utils/extensions.dart';
import 'di.dart' as di;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularNewsCubit>.value(value: di.sl()),
        BlocProvider<AuthCubit>.value(value: di.sl()),
      ],
      child: HiveThemeWidget(
        builder: (context, box, widget, key) {
          bool? isDarkMode = box.get(key);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                brightness: isDarkMode == null
                    ? context.deviceBrightnessMode
                    : isDarkMode == true
                        ? Brightness.dark
                        : Brightness.light,
              ),
              home: const HomePage());
        },
      ),
    );
  }
}
