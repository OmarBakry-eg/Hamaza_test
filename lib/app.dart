import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/hive/hive_services.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/feature/home/presentation/screens/home.dart';
import 'package:news_app_test/utils/extensions.dart';
import 'di.dart' as di;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularNewsCubit>.value(value: di.sl()),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box(HiveBoxes.settings.name).listenable(),
        builder: (context, box, widget) {
          bool? isDarkMode = box.get('darkMode');
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                brightness: isDarkMode == null
                    ? context.deviceBrightnessMode
                    :  isDarkMode == true
                        ? Brightness.dark
                        : Brightness.light,
              ),
              home: const HomePage());
        },
      ),
    );
  }
}
