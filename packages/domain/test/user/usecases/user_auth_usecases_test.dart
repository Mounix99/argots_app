import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/usecases/user_auth_usecases/signin_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signout_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'user_auth_usecases_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<UserAuthRepository>(as: #MockUserAuthRepository), MockSpec<AuthResponse>(as: #MockAuthResponse)])
void main() {
  late MockUserAuthRepository mockUserAuthRepository;
  late SignUpUsecase signUpUseCase;
  late SignInUsecase signInUseCase;
  late SignOutUsecase signOutUseCase;

  setUp(() {
    mockUserAuthRepository = MockUserAuthRepository();
    signUpUseCase = SignUpUsecase(mockUserAuthRepository);
    signInUseCase = SignInUsecase(mockUserAuthRepository);
    signOutUseCase = SignOutUsecase(mockUserAuthRepository);
  });

  group("Domain/User/SignUp", () {
    final Map<String, dynamic> userData = {"email": "", "password": "", "data": <String, dynamic>{}};
    final authResponse = AuthResponse();

    test("/Success/ = should register user successfully", () async {
      when(mockUserAuthRepository.signUpWithEmail(
              email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")))
          .thenAnswer((_) async => Right(authResponse));

      final Either<Failure, AuthResponse> result = await signUpUseCase(userData);

      expect(result, Right(authResponse));

      verify(mockUserAuthRepository.signUpWithEmail(
          email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")));
    });

    test("/Failure/ = should return Failure when registering user fails", () async {
      when(mockUserAuthRepository.signUpWithEmail(
              email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await signUpUseCase(userData);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserAuthRepository.signUpWithEmail(
          email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")));
    });
  });

  group("Domain/User/SignIn", () {
    final Map<String, dynamic> userData = {"email": "", "password": ""};
    final authResponse = AuthResponse();

    test("/Success/ = should register user successfully", () async {
      when(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => Right(authResponse));

      final Either<Failure, AuthResponse> result = await signInUseCase(userData);

      expect(result, Right(authResponse));

      verify(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")));
    });

    test("/Failure/ = should return Failure when registering user fails", () async {
      when(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await signInUseCase(userData);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")));
    });
  });

  group("Domain/User/SignOut", () {
    test("/Success/ = should sign out user successfully", () async {
      when(mockUserAuthRepository.signOut()).thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final Either<Failure, Success> result = await signOutUseCase();

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockUserAuthRepository.signOut());
    });

    test("/Failure/ = should return Failure when signing out user fails", () async {
      when(mockUserAuthRepository.signOut()).thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await signOutUseCase();

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserAuthRepository.signOut());
    });
  });
}
