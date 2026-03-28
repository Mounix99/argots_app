import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/usecases/user_auth_usecases/signin_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signout_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signup_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_auth_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserAuthRepository>(as: #MockUserAuthRepository)])
void main() {
  late MockUserAuthRepository mockUserAuthRepository;
  late SignUpUseCase signUpUseCase;
  late SignInUseCase signInUseCase;
  late SignOutUseCase signOutUseCase;

  const testUser = AppUser(id: 'test-id', email: 'test@example.com');

  setUp(() {
    provideDummy<Either<Failure, AppUser>>(Right(testUser));
    provideDummy<Either<Failure, Success>>(Right(RemoteSourceSuccess()));
    mockUserAuthRepository = MockUserAuthRepository();
    signUpUseCase = SignUpUseCase(mockUserAuthRepository);
    signInUseCase = SignInUseCase(mockUserAuthRepository);
    signOutUseCase = SignOutUseCase(mockUserAuthRepository);
  });

  group("Domain/User/SignUp", () {
    const signUpParams = (email: "test@example.com", password: "password123", data: null);

    test("/Success/ = should register user successfully", () async {
      when(mockUserAuthRepository.signUpWithEmail(
              email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")))
          .thenAnswer((_) async => Right(testUser));

      final Either<Failure, AppUser> result = await signUpUseCase(signUpParams);

      expect(result, Right(testUser));

      verify(mockUserAuthRepository.signUpWithEmail(
          email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")));
    });

    test("/Failure/ = should return Failure when registering user fails", () async {
      when(mockUserAuthRepository.signUpWithEmail(
              email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await signUpUseCase(signUpParams);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserAuthRepository.signUpWithEmail(
          email: anyNamed("email"), password: anyNamed("password"), data: anyNamed("data")));
    });
  });

  group("Domain/User/SignIn", () {
    const signInParams = (email: "test@example.com", password: "password123");

    test("/Success/ = should sign in user successfully", () async {
      when(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => Right(testUser));

      final Either<Failure, AppUser> result = await signInUseCase(signInParams);

      expect(result, Right(testUser));

      verify(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")));
    });

    test("/Failure/ = should return Failure when signing in user fails", () async {
      when(mockUserAuthRepository.signInWithEmail(email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await signInUseCase(signInParams);

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
