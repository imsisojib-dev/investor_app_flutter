// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/errors/error_handler.dart' as _i691;
import '../../core/network/api_client.dart' as _i1059;
import '../../core/network/dio_client.dart' as _i571;
import '../../core/network/interceptors/error_interceptor.dart' as _i494;
import '../../core/network/interceptors/retry_interceptor.dart' as _i814;
import '../../core/network/network_info.dart' as _i892;
import '../../core/storage/i_local_storage_service.dart' as _i1070;
import '../../core/storage/local_storage_service.dart' as _i531;
import '../../features/campaign/data/datasources/remote/campaign_dummy_remote_datasource.dart'
    as _i880;
import '../../features/campaign/data/datasources/remote/campaign_remote_datasource.dart'
    as _i700;
import '../../features/campaign/data/datasources/remote/i_campaign_remote_datasource.dart'
    as _i141;
import '../../features/campaign/data/repositories/campaign_repository_impl.dart'
    as _i684;
import '../../features/campaign/domain/repositories/i_campaign_repository.dart'
    as _i281;
import '../../features/campaign/domain/usecases/usecase_fetch_campaigns.dart'
    as _i597;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import 'modules/network_module.dart' as _i851;
import 'modules/storage_module.dart' as _i148;

const String _mock = 'mock';
const String _prod = 'prod';
const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i691.ErrorHandler>(() => _i691.ErrorHandler());
    gh.lazySingleton<_i494.ErrorInterceptor>(() => _i494.ErrorInterceptor());
    gh.lazySingleton<_i141.ICampaignRemoteDatasource>(
      () => _i880.CampaignDummyRemoteDataSource(),
      registerFor: {_mock},
    );
    gh.lazySingleton<_i1070.ILocalStorageService>(
      () => _i531.LocalStorageService(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i892.INetworkInfo>(
      () => _i892.NetworkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i814.RetryInterceptor>(
      () => _i814.RetryInterceptor(gh<_i892.INetworkInfo>()),
    );
    gh.lazySingleton<_i571.DioClient>(
      () => _i571.DioClient(
        gh<String>(),
        gh<_i814.RetryInterceptor>(),
        gh<_i494.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i1059.IApiClient>(
      () => _i1059.ApiClient(gh<_i571.DioClient>()),
    );
    gh.lazySingleton<_i141.ICampaignRemoteDatasource>(
      () => _i700.CampaignRemoteDatasource(gh<_i1059.IApiClient>()),
      registerFor: {_prod, _dev},
    );
    gh.lazySingleton<_i281.ICampaignRepository>(
      () => _i684.CampaignRepositoryImpl(gh<_i141.ICampaignRemoteDatasource>()),
    );
    gh.lazySingleton<_i597.GetCampaignDetailUseCase>(
      () => _i597.GetCampaignDetailUseCase(gh<_i281.ICampaignRepository>()),
    );
    gh.factory<_i202.HomeBloc>(
      () => _i202.HomeBloc(gh<_i597.GetCampaignDetailUseCase>()),
    );
    return this;
  }
}

class _$StorageModule extends _i148.StorageModule {}

class _$NetworkModule extends _i851.NetworkModule {}
