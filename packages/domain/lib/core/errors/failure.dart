import "package:equatable/equatable.dart";

sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class RemoteSourceFailure extends Failure {}

class CacheFailure extends Failure {}
