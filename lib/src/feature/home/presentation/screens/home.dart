import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_test/src/core/loggers/logger.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_state.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/failure_widget.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/gradient_container.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/network_icon_widget.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/news_article_title.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/pull_to_ref_widget.dart';
import 'package:news_app_test/src/feature/setting/presentation/screen/setting_page.dart';
import 'package:news_app_test/src/utils/my_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PopularNewsCubit>().loadPopularNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PopularNewsCubit, PopularNewsState>(
          listener: (ctx, state) => Logger.logInfo("current state is $state"),
          builder: (context, state) {
            return state is LoadingPopularNewsState
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: MyTheme.gradientColors[1], size: 100))
                : state is FailurePopularNewsState
                    ? FailureWidget(
                        errorMessage: state.errorMessage,
                      )
                    : state is LoadedPopularNewsState ||
                            (state is OnlineStatus &&
                                state.articleList != null &&
                                state.articleList!.isNotEmpty) ||
                            (state is OfflineStatus &&
                                state.articleList != null &&
                                state.articleList!.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(22),
                            child: RefreshIndicator.adaptive(
                              onRefresh: () async {
                                context
                                    .read<PopularNewsCubit>()
                                    .loadPopularNewsData();
                              },
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    state is OnlineStatus
                                        ? const PullToRefreshWidget()
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
                                                const NetworkIconWidget()
                                              ],
                                            ),
                                            const Text(
                                              "Read your favourite news in one click",
                                              style: MyTheme.displaySmall,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
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
                                          padding: EdgeInsets.zero,
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
                          ).animate().scale()
                        : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
