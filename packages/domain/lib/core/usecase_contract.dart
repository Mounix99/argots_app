import "package:dartz/dartz.dart";

import "errors/failure.dart";

abstract interface class Usecase<Type, ParamMap> {
  Future<Either<Failure, Type>> call(ParamMap params);
}

abstract interface class UsecaseNoParam<Type> {
  Future<Either<Failure, Type>> call();
}
