import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/feature/login/presentation/cubit/auth_cubit.dart';
import 'package:news_app_test/feature/login/presentation/screens/sign_in_page.dart';
import 'package:news_app_test/utils/constants.dart';
import 'package:news_app_test/utils/extensions.dart';
import 'package:news_app_test/utils/my_theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Interface',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Use dark mode',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Get that whiteness out',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                HiveThemeWidget(
                  builder: (context, box, widget, key) {
                    bool? isDarkMode = box.get(key);
                    return Switch(
                      value: isDarkMode ??
                          context.deviceBrightnessMode == Brightness.dark,
                      onChanged: (value) async {
                        isDarkMode = value;
                        await box.put(key, isDarkMode);
                      },
                    );
                  },
                ),
              ],
            ),
            const Divider(
              height: 23,
            ),
            StreamBuilder(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (c, snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data?.emailVerified == true) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  Text("Logged in as ${snapshot.data?.email}"),
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseUIAuth.signOut();
                              },
                              child: Text(
                                "Logout",
                                style: MyTheme.displayMedium
                                    .copyWith(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Divider(
                                height: 23,
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<AuthCubit>()
                                      .deleteAccountLogic();
                                },
                                child: Text(
                                  "Delete Account",
                                  style: MyTheme.displayMedium.copyWith(
                                      fontSize: 17, color: Colors.red),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child:
                                    BlocBuilder<AuthCubit, AuthStateInternal>(
                                        builder: (context, state) => state
                                                is DeleteAccountLoading
                                            ? const CircularProgressIndicator
                                                .adaptive()
                                            : state is DeleteAccounthErrorState
                                                ? Text(state.message)
                                                : const SizedBox.shrink()),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (c) => const SignInPage()));
                    },
                    child: const Text(
                      "Login",
                      style: MyTheme.displayMedium,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
