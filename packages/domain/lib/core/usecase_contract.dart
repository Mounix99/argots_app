import "package:fpdart/fpdart.dart";

import "errors/failure.dart";

abstract interface class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

abstract interface class UseCaseNoParam<T> {
  Future<Either<Failure, T>> call();
}
