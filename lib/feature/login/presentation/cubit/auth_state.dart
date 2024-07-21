part of 'auth_cubit.dart';

sealed class AuthStateInternal extends Equatable {
  const AuthStateInternal();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthStateInternal {}

final class AuthBiometricLoading extends AuthStateInternal {}

final class AuthBiometricSuccess extends AuthStateInternal {
  final UserCredential? userCredential;
  const AuthBiometricSuccess(this.userCredential);

  @override
  List<Object> get props => [
        if (userCredential != null) {userCredential}
      ];
}

final class DeleteAccountLoading extends AuthStateInternal {}

final class DeleteAccountSuccess extends AuthStateInternal {}

final class DeleteAccounthErrorState extends AuthStateInternal {
  final String message;
  const DeleteAccounthErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthErrorState extends AuthStateInternal {
  final String message;
  const AuthErrorState(this.message);

  @override
  List<Object> get props => [message];
}
