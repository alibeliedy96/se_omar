
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/choose_available_days_to_book/domain/repositories/choose_days_and_book_repository.dart';
import '../../modules/choose_available_days_to_book/domain/repositories/choose_days_and_book_repository_interface.dart';
import '../../modules/choose_available_days_to_book/domain/services/choose_days_and_book_service.dart';
import '../../modules/choose_available_days_to_book/domain/services/choose_days_and_book_service_interface.dart';
import '../../modules/choose_available_days_to_book/logic/choose_days_and_book_cubit/choose_days_and_book_cubit.dart';
import '../../modules/explore/domain/repositories/explore_repository.dart';
import '../../modules/explore/domain/repositories/explore_repository_interface.dart';
import '../../modules/explore/domain/services/explore_service.dart';
import '../../modules/explore/domain/services/explore_service_interface.dart';
import '../../modules/explore/logic/explore_cubit/explore_cubit.dart';
import '../../modules/myTrips/domain/repositories/reservations_repository.dart';
import '../../modules/myTrips/domain/repositories/reservations_repository_interface.dart';
import '../../modules/myTrips/domain/services/reservations_service.dart';
import '../../modules/myTrips/domain/services/reservations_service_interface.dart';
import '../../modules/myTrips/logic/reservations_cubit/reservations_cubit.dart';
import '../../modules/unit_details/domain/repositories/unit_details_repository.dart';
import '../../modules/unit_details/domain/repositories/unit_details_repository_interface.dart';
import '../../modules/unit_details/domain/services/unit_details_service.dart';
import '../../modules/unit_details/domain/services/unit_details_service_interface.dart';
import '../../modules/unit_details/logic/unit_details_cubit/unit_details_cubit.dart';
import '../../modules/login/domain/repositories/auth_repository.dart';
import '../../modules/login/domain/repositories/auth_repository_interface.dart';
import '../../modules/login/domain/services/auth_service.dart';
import '../../modules/login/domain/services/auth_service_interface.dart';
import '../../modules/login/logic/auth_cubit/auth_cubit.dart';
import '../../modules/profile/domain/repositories/profile_repository.dart';
import '../../modules/profile/domain/repositories/profile_repository_interface.dart';
import '../../modules/profile/domain/services/profile_service.dart';
import '../../modules/profile/domain/services/profile_service_interface.dart';
import '../../modules/profile/logic/profile_cubit/profile_cubit.dart';




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
  sl.registerLazySingleton(() => ProfileRepository());
  sl.registerLazySingleton(() => ExploreRepository());
  sl.registerLazySingleton(() => UnitDetailsRepository());
  sl.registerLazySingleton(() => ChooseDaysAndBookRepository());
  sl.registerLazySingleton(() => ReservationsRepository());


}
// ========================== 🔥 interfaces 🔥 ==========================

void initInterfaces() {

  AuthRepositoryInterface  authRepositoryInterface = AuthRepository();
  sl.registerLazySingleton(() => authRepositoryInterface);

  AuthServiceInterface authServiceInterface = AuthService( authRepositoryInterface: sl());
  sl.registerLazySingleton(() => authServiceInterface);

  ProfileRepositoryInterface  profileRepositoryInterface = ProfileRepository();
  sl.registerLazySingleton(() => profileRepositoryInterface);

  ProfileServiceInterface profileServiceInterface = ProfileService( profileRepositoryInterface: sl());
  sl.registerLazySingleton(() => profileServiceInterface);

  ExploreRepositoryInterface  exploreRepositoryInterface = ExploreRepository();
  sl.registerLazySingleton(() => exploreRepositoryInterface);

  ExploreServiceInterface exploreServiceInterface = ExploreService( exploreRepositoryInterface: sl());
  sl.registerLazySingleton(() => exploreServiceInterface);


  UnitDetailsRepositoryInterface  unitDetailsRepositoryInterface = UnitDetailsRepository();
  sl.registerLazySingleton(() => unitDetailsRepositoryInterface);

  UnitDetailsServiceInterface unitDetailsServiceInterface = UnitDetailsService( unitDetailsRepositoryInterface: sl());
  sl.registerLazySingleton(() => unitDetailsServiceInterface);


  ChooseDaysAndBookRepositoryInterface  chooseDaysAndBookRepositoryInterface = ChooseDaysAndBookRepository();
  sl.registerLazySingleton(() => chooseDaysAndBookRepositoryInterface);

  ChooseDaysAndBookServiceInterface chooseDaysAndBookServiceInterface = ChooseDaysAndBookService( chooseDaysAndBookRepositoryInterface: sl());
  sl.registerLazySingleton(() => chooseDaysAndBookServiceInterface);


  ReservationsRepositoryInterface  reservationsRepositoryInterface = ReservationsRepository();
  sl.registerLazySingleton(() => reservationsRepositoryInterface);

  ReservationsServiceInterface reservationsServiceInterface = ReservationsService( reservationsRepositoryInterface: sl());
  sl.registerLazySingleton(() => reservationsServiceInterface);



}
// ========================== 🔥 Services 🔥 ==========================

void initService() {

  sl.registerLazySingleton(() => AuthService(authRepositoryInterface : sl()));
  sl.registerLazySingleton(() => ProfileService(profileRepositoryInterface : sl()));
  sl.registerLazySingleton(() => ExploreService(exploreRepositoryInterface : sl()));
  sl.registerLazySingleton(() => UnitDetailsService(unitDetailsRepositoryInterface : sl()));
  sl.registerLazySingleton(() => ChooseDaysAndBookService(chooseDaysAndBookRepositoryInterface : sl()));
  sl.registerLazySingleton(() => ReservationsService(reservationsRepositoryInterface : sl()));

}
// ========================== 🔥 cubits 🔥 ==========================
void initCubits() {

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(repo: sl()));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(repo: sl()));
  getIt.registerLazySingleton<ExploreCubit>(() => ExploreCubit(repo: sl()));
  getIt.registerLazySingleton<UnitDetailsCubit>(() => UnitDetailsCubit(repo: sl()));
  getIt.registerLazySingleton<ChooseDaysAndBookCubit>(() => ChooseDaysAndBookCubit(repo: sl()));
  getIt.registerLazySingleton<ReservationsCubit>(() => ReservationsCubit(repo: sl()));

}
