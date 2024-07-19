import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_state.dart';
import 'package:news_app_test/feature/home/presentation/widgets/gradient_container.dart';
import 'package:news_app_test/feature/home/presentation/widgets/news_article_title.dart';
import 'package:news_app_test/feature/home/presentation/widgets/read_more_button.dart';
import 'package:news_app_test/feature/setting/presentation/screen/setting_page.dart';
import 'package:news_app_test/utils/my_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularNewsCubit>().loadPopularNewsEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularNewsCubit, PopularNewsState>(
        builder: (context, state) {
          return state is LoadingPopularNewsState
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: MyTheme.gradientColors[1], size: 100))
              : state is FailurePopularNewsState
                  ? Column(
                      children: [
                        SvgPicture.asset("assets/svg/undraw_newspaper.svg",
                            width: 100, height: 100),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.errorMessage),
                        const SizedBox(
                          height: 10,
                        ),
                        HelperButton(
                            title: "Retry",
                            onTap: () {
                              context
                                  .read<PopularNewsCubit>()
                                  .loadPopularNewsEvent();
                            })
                      ],
                    )
                  : state is LoadedPopularNewsState
                      ? SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Discover",
                                              style: MyTheme.displayLarge),

                                          // Text
                                          const Text(
                                            "Read your favourite news in one click",
                                            style: MyTheme.displaySmall,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => SearchPage()),
                                          // );
                                        },
                                        child: const Hero(
                                          tag: 'iconSearch',
                                          child: Icon(
                                            Icons.search,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingsPage(),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.settings,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const GradientContainer(),
                                      const SizedBox(
                                        height: 25,
                                      ),

                                      // Text
                                      const Text(
                                        "Popular News",
                                        style: MyTheme.labelMedium,
                                      ),

                                      // Mapping the ListView data
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.articleList.length,
                                        itemBuilder: (context, index) =>
                                            NewsArticleTile(
                                                    result: state //author
                                                        .articleList[index])
                                                .animate()
                                                .slideX(
                                                    begin: -10,
                                                    end: 0,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves
                                                        .fastEaseInToSlowEaseOut,
                                                    delay: Duration(
                                                        milliseconds:
                                                            200 * index)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
