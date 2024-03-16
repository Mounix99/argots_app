import 'package:data/repository_implementation/user_auth_repository_implementation.dart';
import 'package:data/repository_implementation/user_repository_implementation.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../build_keys.dart';

class DIService {
  static GetIt getIt = GetIt.instance;

  static T get<T extends Object>() => getIt.get<T>();

  static Future<void> init() async {
    await _registerServices();
    await _registerRepositories();
  }

  static Future<void> _registerServices() async {
    getIt.registerSingleton<Supabase>(
        await Supabase.initialize(url: BuildKeys.supabaseUrl, anonKey: BuildKeys.supabaseApiKey));
    getIt.registerSingletonAsync<SharedPreferences>(() async => SharedPreferences.getInstance());
  }

  static Future<void> _registerRepositories() async {
    getIt.registerLazySingleton<UserAuthRepository>(() => UserAuthRepositoryImplementation(
        supabase: getIt.get<Supabase>(), sharedPreferences: getIt.get<SharedPreferences>()));
    getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImplementation(supabase: getIt.get<Supabase>()));
  }
}
