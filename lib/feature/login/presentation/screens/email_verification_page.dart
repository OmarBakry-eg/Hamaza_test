import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_test/core/util/logger.dart';
import 'package:news_app_test/feature/login/presentation/screens/sign_in_page.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      actions: [
        EmailVerifiedAction(() {
          Logger.logInfo("EmailVerifiedAction");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (c) => const SignInPage(
                        headerTitle: "Now please sign in to confirm your data",
                      )));
        }),
        AuthCancelledAction((context) {
          Logger.logInfo("AuthCancelledAction");
          FirebaseUIAuth.signOut(context: context);
          Navigator.pop(context);
        }),
      ],
    );
  }
}