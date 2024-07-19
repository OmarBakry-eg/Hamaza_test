import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_test/feature/home/presentation/screens/home.dart';
import 'di.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularNewsCubit>.value(value: di.sl()),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          var isDarkMode = box.get('darkMode') ?? false;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                brightness: isDarkMode ? Brightness.dark : Brightness.light,
              ),
              home: const HomePage()
            );
        },
      ),
    );
  }
}
