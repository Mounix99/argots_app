import 'package:agrost_app/build_keys.dart';
import 'package:agrost_app/common/navigation/agrost_router.dart';
import 'package:data/remote_data_source/plant_remote_data_source.dart';
import 'package:data/remote_data_source/plant_remote_data_source_impl.dart';
import 'package:data/remote_data_source/user_auth_remote_data_source.dart';
import 'package:data/remote_data_source/user_auth_remote_data_source_impl.dart';
import 'package:data/remote_data_source/user_remote_data_source.dart';
import 'package:data/remote_data_source/user_remote_data_source_impl.dart';
import 'package:data/repository_implementation/plant_repository_implementation.dart';
import 'package:data/repository_implementation/user_auth_repository_implementation.dart';
import 'package:data/repository_implementation/user_repository_implementation.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/delete_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_market_plants_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plants_created_by_me_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_user_plants_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:domain/plants/usecases/plant_usecases/update_plant_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/delete_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/get_stage_info_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/update_stage_usecase.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:domain/user/usecases/user_auth_usecases/signin_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signout_usecase.dart';
import 'package:domain/user/usecases/user_auth_usecases/signup_usecase.dart';
import 'package:domain/user/usecases/user_usecases/get_user_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DIService {
  static GetIt getIt = GetIt.instance;

  static T get<T extends Object>() => getIt.get<T>();

  static Future<void> init() async {
    await _registerServices();
    await _registerDataSources();
    await _registerRepositories();
    await _registerUseCases();
  }

  static Future<void> _registerServices() async {
    getIt.registerSingleton<Supabase>(
      await Supabase.initialize(url: BuildKeys.supabaseUrl, anonKey: BuildKeys.supabaseApiKey),
    );
  }

  static Future<void> _registerDataSources() async {
    getIt.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(supabase: getIt.get<Supabase>()),
    );
    getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(supabase: getIt.get<Supabase>()),
    );
    getIt.registerLazySingleton<PlantRemoteDataSource>(
      () => PlantRemoteDataSourceImpl(supabase: getIt.get<Supabase>()),
    );
  }

  static Future<void> _registerRepositories() async {
    getIt.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImplementation(remoteDataSource: getIt.get<UserAuthRemoteDataSource>()),
    );
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImplementation(remoteDataSource: getIt.get<UserRemoteDataSource>()),
    );
    getIt.registerLazySingleton<PlantsRepository>(
      () => PlantRepositoryImplementation(remoteDataSource: getIt.get<PlantRemoteDataSource>()),
    );
    getIt.registerLazySingleton<GoRouter>(
      () => AgrostRouter(getIt.get<UserAuthRepository>()).router,
    );
  }

  static Future<void> _registerUseCases() async {
    // User auth use cases
    getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(getIt.get<UserAuthRepository>()),
    );
    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(getIt.get<UserAuthRepository>()),
    );
    getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(getIt.get<UserAuthRepository>()),
    );

    // User use cases
    getIt.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(getIt.get<UserRepository>()),
    );

    // Plant use cases
    getIt.registerLazySingleton<AddPlantUseCase>(
      () => AddPlantUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<UpdatePlantUseCase>(
      () => UpdatePlantUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<DeletePlantUseCase>(
      () => DeletePlantUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetPlantInfoUseCase>(
      () => GetPlantInfoUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetMarketPlantsUseCase>(
      () => GetMarketPlantsUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetUserPlantsUseCase>(
      () => GetUserPlantsUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetPlantsCreatedByMeUseCase>(
      () => GetPlantsCreatedByMeUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<AddPlantToUserUseCase>(
      () => AddPlantToUserUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<RemovePlantFromUserUseCase>(
      () => RemovePlantFromUserUseCase(getIt.get<PlantsRepository>()),
    );

    // Stage use cases
    getIt.registerLazySingleton<AddStageUseCase>(
      () => AddStageUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<UpdateStageUseCase>(
      () => UpdateStageUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<DeleteStageUseCase>(
      () => DeleteStageUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetListOfStagesUseCase>(
      () => GetListOfStagesUseCase(getIt.get<PlantsRepository>()),
    );
    getIt.registerLazySingleton<GetStageInfoUseCase>(
      () => GetStageInfoUseCase(getIt.get<PlantsRepository>()),
    );
  }
}
