
import 'package:flutter/material.dart';

extension DarkMode on BuildContext {

  Brightness get deviceBrightnessMode {
    final brightness = MediaQuery.platformBrightnessOf(this);
    return brightness;
  }
  
}


// extension U on firebase_auth.User {
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
