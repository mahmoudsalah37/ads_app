import 'package:ads_app/features/home/domain/usecases/get_ads_usecase.dart';
import 'package:ads_app/features/home/presentation/controllers/home_controller.dart';
import 'package:get_it/get_it.dart';

import '../features/home/data/datasources/ads_datasource.dart';
import '../features/home/data/repositories/ads_repository_imp.dart';
import '../features/home/domain/repositories/ads_repository.dart';

class InjectionContainer {
  static final sl = GetIt.instance;
  static final instance = InjectionContainer();
  Future<void> init() async {
    // Datasources
    sl.registerLazySingleton<AdsDatasource>(() => AdsDatasourceImp());

    // Repositories
    sl.registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImp(adsDatasource: sl<AdsDatasource>()),
    );

    // Usecases
    sl.registerLazySingleton<GetAdsUsecase>(
      () => GetAdsUsecase(adsRepository: sl<AdsRepository>()),
    );

    // Controllers
    sl.registerLazySingleton<HomeController>(
      () => HomeController(getAdsUsecase: sl<GetAdsUsecase>()),
    );
  }
}
