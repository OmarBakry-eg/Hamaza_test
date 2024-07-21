import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_test/core/util/logger.dart';
import 'package:news_app_test/feature/login/presentation/cubit/auth_cubit.dart';
import 'package:news_app_test/feature/login/presentation/screens/email_verification_page.dart';
import 'package:news_app_test/utils/constants.dart';
import 'package:news_app_test/utils/my_theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SignInPage extends StatelessWidget {
  final String? headerTitle;
  const SignInPage({super.key, this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SignInScreen(
        headerBuilder: (context, constraints, shrinkOffset) {
          return Column(
            children: [
              const HamzahNewsTitle(),
              if (headerTitle != null) ...{
                const SizedBox(height: 20),
                Text(
                  headerTitle!,
                  style: MyTheme.displaySmall
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              }
            ],
          );
        },
        footerBuilder: (context, action) {
          return action == AuthAction.signIn
              ? BlocBuilder<AuthCubit, AuthStateInternal>(
                  buildWhen: (p, c) =>
                      c is AuthInitial ||
                      c is AuthBiometricSuccess ||
                      c is AuthErrorState ||
                      c is AuthBiometricLoading,
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().bioMerticAuth();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Lottie.asset("assets/lottie/biometric.json",
                              width: 70, height: 70),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Biometric Authentication",
                            style: MyTheme.displaySmall
                                .copyWith(color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          state is AuthBiometricLoading
                              ? const CircularProgressIndicator.adaptive()
                              : state is AuthErrorState
                                  ? Text(state.message)
                                  : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox.shrink();
        },
        actions: [
          AuthStateChangeAction<UserCreated>((context, state) {
            if (!state.credential.user!.emailVerified) {
              state.credential.user?.sendEmailVerification();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const EmailVerificationPage()));
            } else {
              context.read<AuthCubit>().saveUserDataLogic(state.credential);
              Navigator.pop(context);
            }
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            if (!state.user!.emailVerified) {
              state.user?.sendEmailVerification();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const EmailVerificationPage()));
            } else {
              Navigator.pop(context);
            }
          }),
        ],
        providers: [
          EmailAuthProvider() 
        ],
        auth: FirebaseAuth.instance,
      ),
    );
  }
}
