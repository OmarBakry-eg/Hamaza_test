part of 'auth_cubit.dart';

sealed class AuthStateInternal extends Equatable {
  const AuthStateInternal();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthStateInternal {}

final class AuthBiometricLoading extends AuthStateInternal {}

final class AuthBiometricSuccess extends AuthStateInternal {
  final User? user;
  const AuthBiometricSuccess(this.user);

  @override
  List<Object> get props => [
        if (user != null) {user}
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

final class FireAuthErrorState extends AuthStateInternal {
  final Exception exception;
  const FireAuthErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
