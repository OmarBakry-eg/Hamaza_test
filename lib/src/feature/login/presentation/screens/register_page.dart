import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:news_app_test/src/feature/login/presentation/screens/email_verification_page.dart';
import 'package:news_app_test/src/feature/login/presentation/screens/sign_in_page.dart';
import 'package:news_app_test/src/feature/login/presentation/widgets/title.dart';
import 'package:news_app_test/src/utils/constants.dart';
import 'package:news_app_test/src/utils/my_theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: FirebaseUIActions(
        actions: [
          AuthStateChangeAction<UserCreated>((context, state) {
            if (!state.credential.user!.emailVerified) {
              state.credential.user?.sendEmailVerification();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const EmailVerificationPage()));
            } else {
              Navigator.pop(context);
            }
          }),
        ],
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: CustomScrollView(slivers: [
              const SliverToBoxAdapter(
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: HamzahNewsTitle()),
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
                            const TitleWidget(text: "Register"),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Already have an account? ",
                                    style: MyTheme.displaySmall,
                                  ),
                                  TextSpan(
                                    text: "Sign in",
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
                                                  const SignInPage())),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 24),
                    const EmailForm(
                      action: AuthAction.signUp,
                    ),
                    const SizedBox(height: 50),
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
