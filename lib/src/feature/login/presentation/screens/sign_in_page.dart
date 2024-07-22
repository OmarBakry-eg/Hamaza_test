import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_test/src/feature/login/presentation/cubit/auth_cubit.dart';
import 'package:news_app_test/src/feature/login/presentation/screens/email_verification_page.dart';
import 'package:news_app_test/src/feature/login/presentation/screens/register_page.dart';
import 'package:news_app_test/src/feature/login/presentation/widgets/title.dart';
import 'package:news_app_test/src/utils/constants.dart';
import 'package:news_app_test/src/utils/my_theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SignInPage extends StatelessWidget {
  final String? headerTitle;
  const SignInPage({super.key, this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool? p) {
        context.read<AuthCubit>().initCubit();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: HamzahNewsTitle()),
                    if (headerTitle != null) ...{
                      const SizedBox(height: 20),
                      Text(
                        headerTitle!,
                        style: MyTheme.displaySmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    },
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleWidget(text: "Sign In"),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Don't have an account? ",
                                    style: MyTheme.displaySmall,
                                  ),
                                  TextSpan(
                                    text: "Register",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: CupertinoUserInterfaceLevel
                                                      .maybeOf(context) !=
                                                  null
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                        ),
                                    mouseCursor: SystemMouseCursors.click,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (c) =>
                                                  const RegisterPage())),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 24),
                    AuthFlowBuilder<EmailAuthController>(
                      listener: (old, state, _) {
                        if (state is SignedIn) {
                          if (state.user != null &&
                              !state.user!.emailVerified) {
                            state.user?.sendEmailVerification();
                            context.read<AuthCubit>().initCubit();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        const EmailVerificationPage()));
                          } else {
                            Navigator.pop(context);
                            context
                                .read<AuthCubit>()
                                .saveUserDataLogicInLocal();
                          }
                        }
                        if (state is AuthFailed) {
                          context
                              .read<AuthCubit>()
                              .handleFireUIExp(state.exception);
                        }
                      },
                      builder: (context, _, ctrl, ___) => EmailForm(
                        action: AuthAction.signIn,
                        onSubmit: (String? email, String? password) {
                          if (email != null &&
                              password != null &&
                              email.isNotEmpty &&
                              password.isNotEmpty) {
                            ctrl.setEmailAndPassword(email, password);
                            context.read<AuthCubit>().onSubmit(email, password);
                            context.read<AuthCubit>().initCubit();
                          }
                        },
                      ),
                    ),
                    BlocBuilder<AuthCubit, AuthStateInternal>(
                        buildWhen: (p, c) =>
                            c is FireAuthErrorState || c is AuthInitial,
                        builder: (context, state) => state is FireAuthErrorState
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ErrorText(
                                  textAlign: TextAlign.center,
                                  exception: state.exception,
                                ),
                              )
                            : const SizedBox.shrink()),
                    BlocConsumer<AuthCubit, AuthStateInternal>(
                      listener: (c, s) {
                        if (s is AuthBiometricSuccess) {
                          Navigator.pop(context);
                        }
                      },
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
                            mainAxisSize: MainAxisSize.min,
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
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
