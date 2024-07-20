// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:news_app_test/core/errors/exceptions.dart';
// import 'package:news_app_test/feature/login/data/model/auth_user.dart';

// abstract class AuthenticationClient {
//   Stream<AuthenticationUser> get user;
//   Future<void> loginWithEmailAndPassword({
//     required String email,
//     required String password,
//   });
//   Future<void> signUpWithEmailAndPassword({
//     required String email,
//     required String password,
//   });

//   Future<void> logOut();

//   Future<void> deleteAccount();
// }

// class FirebaseAuthenticationClient implements AuthenticationClient {
//   /// {@macro firebase_authentication_client}
//   FirebaseAuthenticationClient({
//     firebase_auth.FirebaseAuth? firebaseAuth,
//   }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance {
//     user.listen(_onUserChanged);
//   }
//   final firebase_auth.FirebaseAuth _firebaseAuth;

//   /// Stream of [AuthenticationUser] which will emit the current user when
//   /// the authentication state changes.
//   ///
//   /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
//   @override
//   Stream<AuthenticationUser> get user {
//     return _firebaseAuth.authStateChanges().map((firebaseUser) {
//       return firebaseUser == null
//           ? AuthenticationUser.anonymous
//           : firebaseUser.toUser;
//     });
//   }

//   /// Sends an authentication link to the provided [email].
//   ///
//   /// Opening the link redirects to the app with [appPackageName]
//   /// using Firebase Dynamic Links and authenticates the user
//   /// based on the provided email link.
//   ///
//   /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
//   @override
//   Future<void> sendLoginEmailLink({
//     required String email,
//     required String appPackageName,
//   }) async {
//     try {
//       final redirectUrl = Uri.https(
//         const String.fromEnvironment('FLAVOR_DEEP_LINK_DOMAIN'),
//         const String.fromEnvironment('FLAVOR_DEEP_LINK_PATH'),
//         <String, String>{'email': email},
//       );

//       final actionCodeSettings = firebase_auth.ActionCodeSettings(
//         url: redirectUrl.toString(),
//         handleCodeInApp: true,
//         iOSBundleId: appPackageName,
//         androidPackageName: appPackageName,
//         androidInstallApp: true,
//       );

//       await _firebaseAuth.sendSignInLinkToEmail(
//         email: email,
//         actionCodeSettings: actionCodeSettings,
//       );
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
//     }
//   }

//   /// Checks if an incoming [emailLink] is a sign-in with email link.
//   ///
//   /// Throws a [IsLogInWithEmailLinkFailure] if an exception occurs.
//   @override
//   bool isLogInWithEmailLink({required String emailLink}) {
//     try {
//       return _firebaseAuth.isSignInWithEmailLink(emailLink);
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(IsLogInWithEmailLinkFailure(error), stackTrace);
//     }
//   }

//   /// Signs in with the provided [emailLink].
//   ///
//   /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
//   @override
//   Future<void> logInWithEmailLink({
//     required String email,
//     required String emailLink,
//   }) async {
//     try {
//       await _firebaseAuth.signInWithEmailLink(
//         email: email,
//         emailLink: emailLink,
//       );
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
//     }
//   }

//   /// Signs out the current user which will emit
//   /// [AuthenticationUser.anonymous] from the [user] Stream.
//   ///
//   /// Throws a [LogOutFailure] if an exception occurs.
//   @override
//   Future<void> logOut() async {
//     try {
//       await Future.wait([
//         _firebaseAuth.signOut(),
//       ]);
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(ServerException(error), stackTrace);
//     }
//   }

//   /// Deletes and signs out the user.
//   @override
//   Future<void> deleteAccount() async {
//     try {
//       final user = _firebaseAuth.currentUser;
//       if (user == null) {
//         throw DeleteAccountFailure(
//           Exception('User is not authenticated'),
//         );
//       }

//       await user.delete();
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(DeleteAccountFailure(error), stackTrace);
//     }
//   }

//   // /// Updates the user token in [TokenStorage] if the user is authenticated.
//   // Future<void> _onUserChanged(AuthenticationUser user) async {
//   //   if (!user.isAnonymous) {
//   //     await _tokenStorage.saveToken(user.id);
//   //   } else {
//   //     await _tokenStorage.clearToken();
//   //   }
//   // }
// }

// extension on firebase_auth.User {
//   AuthenticationUser get toUser {
//     return AuthenticationUser(
//       id: uid,
//       email: email,
//       name: displayName,
//       photo: photoURL,
//       isNewUser: metadata.creationTime == metadata.lastSignInTime,
//     );
//   }
// }
