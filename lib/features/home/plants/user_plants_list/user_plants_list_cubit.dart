import 'package:equatable/equatable.dart';

import '../../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

class MyPlantsState extends Equatable {
  final RequestState myPlantsRequestState;

  final int page;

  const MyPlantsState({
    required this.myPlantsRequestState,
    required this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
