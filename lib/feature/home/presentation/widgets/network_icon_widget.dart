import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_state.dart';

class NetworkIconWidget extends StatelessWidget {
  const NetworkIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularNewsCubit, PopularNewsState>(
      buildWhen: (prev, curr) =>
          curr is OnlineStatus ||
          curr is OfflineStatus ||
          curr is InitialPopularNewsState,
      builder: (context, state) {
        return Tooltip(
          message: state is OfflineStatus ? "You're offline" : "You're online",
          child: Icon(
            state is OfflineStatus ? Icons.wifi_off : Icons.wifi,
            color: state is OfflineStatus ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }
}
