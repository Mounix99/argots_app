import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());
}

class ProfileState extends Equatable {
  const ProfileState();

  factory ProfileState.initial() => const ProfileState();

  @override
  List<Object?> get props => [];
}
