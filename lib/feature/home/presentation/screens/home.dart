import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_test/core/util/logger.dart';
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
    context.read<PopularNewsCubit>().loadPopularNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PopularNewsCubit, PopularNewsState>(
        listener: (ctx, state) => Logger.logInfo("current state is $state"),
        builder: (context, state) {
          return state is LoadingPopularNewsState
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: MyTheme.gradientColors[1], size: 100))
              : state is FailurePopularNewsState
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svg/undraw_newspaper.svg",
                              width: 150, height: 150),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          HelperButton(
                              title: "Retry",
                              onTap: () {
                                context
                                    .read<PopularNewsCubit>()
                                    .loadPopularNewsData();
                              })
                        ],
                      ),
                    )
                  : state is LoadedPopularNewsState ||
                          state is OnlineStatus ||
                          state is OfflineStatus
                      ? SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: RefreshIndicator.adaptive(
                              onRefresh: () async {
                                context
                                    .read<PopularNewsCubit>()
                                    .loadPopularNewsData();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    state is OnlineStatus
                                        ? BlocBuilder<PopularNewsCubit,
                                            PopularNewsState>(
                                            buildWhen: (prev, curr) =>
                                                curr is OnlineStatus,
                                            builder: (context, state) {
                                              return Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Lottie.asset(
                                                        "assets/lottie/pull_to_ref.json",
                                                        width: 30,
                                                        height: 30),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                        "Pull to refresh"),
                                                    const SizedBox(height: 5),
                                                  ],
                                                ),
                                              ).animate().slideY();
                                            },
                                          )
                                        : const SizedBox.shrink(),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Discover",
                                                    style:
                                                        MyTheme.displayLarge),
                                                const SizedBox(width: 15),
                                                BlocBuilder<PopularNewsCubit,
                                                    PopularNewsState>(
                                                  buildWhen: (prev, curr) =>
                                                      curr is OnlineStatus ||
                                                      curr is OfflineStatus ||
                                                      curr
                                                          is InitialPopularNewsState,
                                                  builder: (context, state) {
                                                    return Tooltip(
                                                      message:
                                                          state is OfflineStatus
                                                              ? "You're offline"
                                                              : "You're online",
                                                      child: Icon(
                                                        state is OfflineStatus
                                                            ? Icons.wifi_off
                                                            : Icons.wifi,
                                                        color: state
                                                                is OfflineStatus
                                                            ? Colors.red
                                                            : Colors.green,
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                            const Text(
                                              "Read your favourite news in one click",
                                              style: MyTheme.displaySmall,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     // Navigator.push(
                                        //     //   context,
                                        //     //   MaterialPageRoute(builder: (context) => SearchPage()),
                                        //     // );
                                        //   },
                                        //   child: const Hero(
                                        //     tag: 'iconSearch',
                                        //     child: Icon(
                                        //       Icons.search,
                                        //       size: 25,
                                        //     ),
                                        //   ),
                                        // ),
                                        //const SizedBox(width: 20),
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
                                        const Text(
                                          "Popular News",
                                          style: MyTheme.labelMedium,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: state.articleList!.length,
                                          itemBuilder: (context, index) =>
                                              NewsArticleTile(
                                                      result: state //author
                                                          .articleList![index])
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
                          ),
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
