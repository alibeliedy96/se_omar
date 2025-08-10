
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/login/domain/repositories/auth_repository.dart';
import '../../modules/login/domain/repositories/auth_repository_interface.dart';
import '../../modules/login/domain/services/auth_service.dart';
import '../../modules/login/domain/services/auth_service_interface.dart';
import '../../modules/login/logic/auth_cubit/auth_cubit.dart';




final getIt = GetIt.instance;
final sl = GetIt.instance;
Future setupGetIt() async {
  await initPublicServices();
  initCubits();
  initRepositories();
  initInterfaces();
  initService();
}

// ========================== 🔥 Public services 🔥 ==========================
Future initPublicServices() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  // getIt.registerSingleton<CacheServices>(SharedPrefsCacheService(prefs: prefs));
  // AppSessionManager.init();
  // getIt.registerSingleton<IApiService>(DioApiService());
}
// ========================== 🔥 repositories 🔥 ==========================

void initRepositories() {

  sl.registerLazySingleton(() => AuthRepository());


}
// ========================== 🔥 interfaces 🔥 ==========================

void initInterfaces() {

  AuthRepositoryInterface  authRepositoryInterface = AuthRepository();
  sl.registerLazySingleton(() => authRepositoryInterface);

  AuthServiceInterface authServiceInterface = AuthService( authRepositoryInterface: sl());
  sl.registerLazySingleton(() => authServiceInterface);



}
// ========================== 🔥 Services 🔥 ==========================

void initService() {

  sl.registerLazySingleton(() => AuthService(authRepositoryInterface : sl()));

}
// ========================== 🔥 cubits 🔥 ==========================
void initCubits() {

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(repo: sl()));

}
