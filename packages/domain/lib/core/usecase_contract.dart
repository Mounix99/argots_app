import "package:fpdart/fpdart.dart";

import "errors/failure.dart";

abstract interface class Usecase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

abstract interface class UsecaseNoParam<T> {
  Future<Either<Failure, T>> call();
}
