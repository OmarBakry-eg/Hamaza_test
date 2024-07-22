import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/biometric_usecase.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/delete_account_usecase.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/save_user_data.dart';
import 'package:news_app_test/src/utils/constants.dart' as consts;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStateInternal> {
  final DeleteAccount deleteAccount;
  final BiometricUsecase biometricUsecase;
  final SaveUserData saveUserData;
  AuthCubit(
      {required this.deleteAccount,
      required this.biometricUsecase,
      required this.saveUserData})
      : super(AuthInitial());

  //* Init logic
  void initCubit() {
    emit(AuthInitial());
  }

  //* Handle firebase UI errors
  void handleFireUIExp(Exception exception) {
    emit(FireAuthErrorState(exception));
  }

  //* Biometric Authentication
  final LocalAuthentication _auth = LocalAuthentication();

  String? email, password;

  void onSubmit(String email, String password) {
    this.email = email;
    this.password = password;
  }

  Future<(bool, String)> get _checkBioMetric async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      if (!canAuthenticateWithBiometrics) {
        return (false, "Cannot check biometrics, this is a platform exception");
      }
    } catch (e) {
      consts.showToast("Cannot check biometrics, this is a platform exception");
      return (false, "Cannot check biometrics, this is a platform exception");
    }
    try {
      final bool canAuthenticate = await _auth.isDeviceSupported();
      if (!canAuthenticate) {
        return (false, "Your device is not supported biometrics");
      }
    } catch (e) {
      consts.showToast("Your device is not supported biometrics");
      return (false, "Your device is not supported biometrics");
    }
    return (true, '');
  }

  void bioMerticAuth() async {
    final (bool, String) checking = await _checkBioMetric;
    if (!checking.$1) {
      consts.showToast(checking.$2);
      return;
    }
    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason:
              'Please authenticate to valiadte your data to be able to access the application',
          options: const AuthenticationOptions(stickyAuth: true));
      if (!didAuthenticate) {
        consts.showToast('Error while authenticating');
        return;
      }
      _bioMetricLoginFunc();
    } catch (e) {
      consts.showToast(e.toString());
      return;
    }
  }

  void _bioMetricLoginFunc() async {
    emit(AuthBiometricLoading());
    final Either<Failure, User>? res = await biometricUsecase();
    if (res != null) {
      emit(_loginEmitErrorOrData(res));
    }
  }

  AuthStateInternal _loginEmitErrorOrData(Either<Failure, User> res) {
    return res.fold((failure) {
      return AuthErrorState(failure.message);
    }, (data) {
      return AuthBiometricSuccess(data);
    });
  }

  //* Delete Account Logic

  void deleteAccountLogic() async {
    emit(DeleteAccountLoading());
    final Either<Failure, bool> res = await deleteAccount();
    emit(_deleteEmitErrorOrData(res));
  }

  AuthStateInternal _deleteEmitErrorOrData(Either<Failure, bool> res) {
    return res.fold((failure) {
      return DeleteAccounthErrorState(failure.message);
    }, (data) {
      return DeleteAccountSuccess();
    });
  }

  //* Save User Data
  void saveUserDataLogicInLocal() async {
    initCubit();
    if (email != null && password != null) {
      Either<Failure, bool>? res =
          await saveUserData(email: email!, password: password!);
      if (res != null) {
        res.isRight()
            ? consts.showToast("Data saved successfully")
            : consts.showToast("Error while saving user data");
      }
    } else {
      consts.showToast("Email or password cannot be null");
    }
  }
}
