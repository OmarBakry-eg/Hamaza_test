import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_test/core/util/logger.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      actions: [
        EmailVerifiedAction(() {
          Logger.logInfo("EmailVerifiedAction");
          Navigator.pop(context);
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
