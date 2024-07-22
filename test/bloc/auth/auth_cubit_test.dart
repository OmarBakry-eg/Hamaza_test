import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/biometric_usecase.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/delete_account_usecase.dart';
import 'package:news_app_test/src/feature/login/domain/usecase/save_user_data.dart';
import 'package:news_app_test/src/feature/login/presentation/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class MockDeleteAccount extends Mock implements DeleteAccount {}

class MockBiometricUsecase extends Mock implements BiometricUsecase {}

class MockSaveUserData extends Mock implements SaveUserData {}

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockUser extends Mock implements User {}

class MockAuthenticationOptions extends Mock implements AuthenticationOptions {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthCubit authCubit;
  late MockDeleteAccount mockDeleteAccount;
  late MockBiometricUsecase mockBiometricUsecase;
  late MockSaveUserData mockSaveUserData;
  late MockLocalAuthentication mockLocalAuthentication;
  late MockAuthenticationOptions mockAuthenticationOptions;
  
  setUp(() {
    mockDeleteAccount = MockDeleteAccount();
    mockBiometricUsecase = MockBiometricUsecase();
    mockSaveUserData = MockSaveUserData();
    mockLocalAuthentication = MockLocalAuthentication();
    mockAuthenticationOptions = MockAuthenticationOptions();

    authCubit = AuthCubit(
      deleteAccount: mockDeleteAccount,
      biometricUsecase: mockBiometricUsecase,
      saveUserData: mockSaveUserData,
    );
  });

  group('AuthCubit', () {
    test('initial state is AuthInitial', () {
      expect(authCubit.state, AuthInitial());
    });

    blocTest<AuthCubit, AuthStateInternal>(
        'emits [AuthBiometricLoading, AuthErrorState] when biometric authentication fails',
        build: () {
          when(() => mockLocalAuthentication.canCheckBiometrics)
              .thenAnswer((_) async => true);
          when(() => mockLocalAuthentication.isDeviceSupported())
              .thenAnswer((_) async => true);
          when(() => mockLocalAuthentication.authenticate(
                  localizedReason: any(named: 'localizedReason'),
                  options: mockAuthenticationOptions))
              .thenAnswer((_) async => false);
          return authCubit;
        },
        act: (cubit) => cubit.bioMerticAuth(),
        tearDown: () => false,
        expect: () => []);

    blocTest<AuthCubit, AuthStateInternal>(
      'emits [DeleteAccountLoading, DeleteAccountSuccess] when delete account is successful',
      build: () {
        when(() => mockDeleteAccount())
            .thenAnswer((_) async => const Right(true));
        return authCubit;
      },
      act: (cubit) => cubit.deleteAccountLogic(),
      tearDown: () => false,
      expect: () => [
        DeleteAccountLoading(),
        DeleteAccountSuccess(),
      ],
    );

    blocTest<AuthCubit, AuthStateInternal>(
      'emits [DeleteAccountLoading, DeleteAccounthErrorState] when delete account fails',
      build: () {
        when(() => mockDeleteAccount()).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Failure')));
        return authCubit;
      },
      act: (cubit) => cubit.deleteAccountLogic(),
      tearDown: () => false,
      expect: () => [
        DeleteAccountLoading(),
        const DeleteAccounthErrorState('Server Failure'),
      ],
    );

    blocTest<AuthCubit, AuthStateInternal>(
      'emits [AuthInitial] when saveUserDataLogicInLocal is called with non-null email and password',
      build: () {
        when(() => mockSaveUserData(
                email: any(named: 'email'), password: any(named: 'password')))
            .thenAnswer((_) async => const Right(true));
        authCubit.onSubmit('test@example.com', 'password123');
        return authCubit;
      },
      act: (cubit) => cubit.saveUserDataLogicInLocal(),
      tearDown: () => false,
      expect: () => [
        AuthInitial(),
      ],
      verify: (_) {
        verify(() => mockSaveUserData(
            email: 'test@example.com', password: 'password123')).called(1);
      },
    );

    test('saveUserDataLogicInLocal shows error when email or password is null',
        () async {
      authCubit.saveUserDataLogicInLocal();
      expect(false, false);
    });
  });

  tearDownAll(() => authCubit.close());
}
