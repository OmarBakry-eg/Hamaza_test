import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_state.dart';

class PullToRefreshWidget extends StatelessWidget {
  const PullToRefreshWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularNewsCubit, PopularNewsState>(
      buildWhen: (prev, curr) => curr is OnlineStatus,
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/pull_to_ref.json",
                  width: 30, height: 30),
              const SizedBox(height: 10),
              const Text("Pull to refresh"),
              const SizedBox(height: 5),
            ],
          ),
        ).animate().slideY();
      },
    );
  }
}
