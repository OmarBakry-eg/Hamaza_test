import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/feature/home/presentation/widgets/read_more_button.dart';

class FailureWidget extends StatelessWidget {
  final String errorMessage;
  const FailureWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            errorMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          HelperButton(
              title: "Retry",
              onTap: () {
                context.read<PopularNewsCubit>().loadPopularNewsData();
              })
        ],
      ),
    );
  }
}
