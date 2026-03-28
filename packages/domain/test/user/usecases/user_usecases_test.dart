import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:domain/user/usecases/user_usecases/get_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>(as: #MockUserRepository)])
void main() {
  late MockUserRepository mockUserRepository;
  late GetUserUsecase getUserUsecase;

  const testUser = AppUser(id: 'test-id', email: 'test@example.com');

  setUp(() {
    provideDummy<Either<Failure, AppUser?>>(const Right(null));
    mockUserRepository = MockUserRepository();
    getUserUsecase = GetUserUsecase(mockUserRepository);
  });

  group("Domain/User/GetUser", () {
    test("/Success/ = should get user successfully", () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => const Right(testUser));

      final result = await getUserUsecase();

      expect(result, const Right(testUser));

      verify(mockUserRepository.getUser());
    });

    test("/Success/ = should return null when no user is logged in", () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => const Right(null));

      final result = await getUserUsecase();

      expect(result, const Right(null));

      verify(mockUserRepository.getUser());
    });

    test("/Failure/ = should return Failure when getting user fails", () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getUserUsecase();

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserRepository.getUser());
    });
  });
}
