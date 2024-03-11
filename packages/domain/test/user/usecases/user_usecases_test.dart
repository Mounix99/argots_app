import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:domain/user/usecases/user_usecases/get_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'user_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>(as: #MockUserRepository), MockSpec<User?>(as: #MockUser)])
void main() {
  late MockUserRepository mockUserRepository;
  late GetUserUsecase getUserUsecase;
  // late UpdateUserUsecase updateUserUsecase;
  // late DeleteUserUsecase deleteUserUsecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserUsecase = GetUserUsecase(mockUserRepository);
    // updateUserUsecase = UpdateUserUsecase(mockUserRepository);
    // deleteUserUsecase = DeleteUserUsecase(mockUserRepository);
  });

  group("Domain/User/GetUser", () {
    final user = MockUser();
    test("/Success/ = should get user successfully", () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => Right(user));

      final result = await getUserUsecase();

      expect(result, Right(user));

      verify(mockUserRepository.getUser());
    });

    test("/Failure/ = should return Failure when getting user fails", () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getUserUsecase();

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockUserRepository.getUser());
    });
  });

  // group("Domain/User/UpdateUser", () {
  //   final user = User();
  //   test("/Success/ = should update user successfully", () async {
  //     when(mockUserRepository.updateUser(user)).thenAnswer((_) async => Right(user));
  //
  //     final result = await updateUserUsecase(user);
  //
  //     expect(result, Right(user));
  //
  //     verify(mockUserRepository.updateUser(user));
  //   });
  //
  //   test("/Failure/ = should return Failure when updating user fails", () async {
  //     when(mockUserRepository.updateUser(user)).thenAnswer((_) async => const Left(RemoteSourceFailure()));
  //
  //     final result = await updateUserUsecase(user);
  //
  //     expect(result, const Left(RemoteSourceFailure()));
  //
  //     verify(mockUserRepository.updateUser(user));
  //   });
  // });
}
