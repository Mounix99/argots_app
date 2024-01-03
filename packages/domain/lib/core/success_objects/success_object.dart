import 'package:equatable/equatable.dart';

sealed class Success extends Equatable {
  const Success();

  @override
  List<Object> get props => [];
}

class RemoteSourceSuccess extends Success {}

class CacheSuccess extends Success {}
