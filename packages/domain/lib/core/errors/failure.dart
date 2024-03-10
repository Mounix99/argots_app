import "package:equatable/equatable.dart";

sealed class Failure extends Equatable {
  const Failure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class RemoteSourceFailure extends Failure {
  final dynamic remoteError;

  const RemoteSourceFailure({this.remoteError}) : super(remoteError);

  @override
  List<Object> get props => [remoteError];
}

class CacheFailure extends Failure {
  final dynamic cacheError;

  const CacheFailure(this.cacheError) : super(cacheError);

  @override
  List<Object> get props => [cacheError];
}
