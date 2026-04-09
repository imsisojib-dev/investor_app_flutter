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

import '../../core/network/api_client.dart' as _i1059;
import '../../core/network/dio_client.dart' as _i571;
import '../../core/network/interceptors/error_interceptor.dart' as _i494;
import '../../core/network/interceptors/retry_interceptor.dart' as _i814;
import '../../core/network/network_info.dart' as _i892;
import '../../core/storage/i_local_storage_service.dart' as _i1070;
import '../../core/storage/local_storage_service.dart' as _i531;
import 'modules/network_module.dart' as _i851;
import 'modules/storage_module.dart' as _i148;

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
    gh.lazySingleton<_i494.ErrorInterceptor>(() => _i494.ErrorInterceptor());
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
    return this;
  }
}

class _$StorageModule extends _i148.StorageModule {}

class _$NetworkModule extends _i851.NetworkModule {}
