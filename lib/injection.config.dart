// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fortune/data/module/http_module.dart' as _i628;
import 'package:fortune/data/module/shared_preferences_module.dart' as _i212;
import 'package:fortune/data/repository/balance_repository.dart' as _i551;
import 'package:fortune/data/repository/gift_repository.dart' as _i469;
import 'package:fortune/data/repository/random_repository.dart' as _i78;
import 'package:fortune/data/source/local/balance_local_source.dart' as _i728;
import 'package:fortune/data/source/local/gift_local_source.dart' as _i983;
import 'package:fortune/data/source/local/wheel_local_source.dart' as _i367;
import 'package:fortune/data/source/network/random_network_source.dart'
    as _i210;
import 'package:fortune/view/main/balance/cubit/cubit.dart' as _i987;
import 'package:fortune/view/main/inventory/cubit/cubit.dart' as _i212;
import 'package:fortune/view/main/wheel/cubit/cubit.dart' as _i319;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final httpModule = _$HttpModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.singleton<_i519.Client>(() => httpModule.client);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i983.GiftLocalSource>(
      () => _i983.GiftLocalSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i367.WheelLocalSource>(
      () => _i367.WheelLocalSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i210.RandomNetworkSource>(
      () => _i210.RandomNetworkSourceImpl(gh<_i519.Client>()),
    );
    gh.singleton<_i728.BalanceLocalSource>(
      () => _i728.BalanceLocalSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i551.BalanceRepository>(
      () => _i551.BalanceRepositoryImpl(gh<_i728.BalanceLocalSource>()),
    );
    gh.factory<_i469.GiftRepository>(
      () => _i469.GiftRepositoryImpl(
        gh<_i983.GiftLocalSource>(),
        gh<_i728.BalanceLocalSource>(),
      ),
    );
    gh.factory<_i78.RandomRepository>(
      () => _i78.RandomRepositoryImpl(gh<_i210.RandomNetworkSource>()),
    );
    gh.factory<_i987.BalanceCubit>(
      () => _i987.BalanceCubit(gh<_i551.BalanceRepository>()),
    );
    gh.factory<_i319.WheelCubit>(
      () => _i319.WheelCubit(
        gh<_i469.GiftRepository>(),
        gh<_i551.BalanceRepository>(),
        gh<_i367.WheelLocalSource>(),
        gh<_i78.RandomRepository>(),
      ),
    );
    gh.factory<_i212.InventoryCubit>(
      () => _i212.InventoryCubit(gh<_i469.GiftRepository>()),
    );
    return this;
  }
}

class _$HttpModule extends _i628.HttpModule {}

class _$SharedPreferencesModule extends _i212.SharedPreferencesModule {}
