// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';
import 'package:stacked_themes/src/theme_service.dart';

import '../core/ble_provider.dart';
import '../core/iotapi_provider.dart';
import '../core/language_provider.dart';
import '../core/login_provider.dart';
import '../core/ltie_provider.dart';
import '../core/thirdparty_provider.dart';
import '../core/websocket_provider.dart';
import '../services/ble_service.dart';
import '../services/companylogin_service.dart';
import '../services/hacs_service.dart';
import '../services/iotapi_service.dart';
import '../services/ltie_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => ThemeService.getInstance());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LanguageProvider());
  locator.registerLazySingleton(() => BleProvider());
  locator.registerLazySingleton(() => BleService());
  locator.registerLazySingleton(() => LoginProvider());
  locator.registerLazySingleton(() => CompanyLoginService());
  locator.registerLazySingleton(() => IotapiService());
  locator.registerLazySingleton(() => IotApiProvider());
  locator.registerLazySingleton(() => LtieProvider());
  locator.registerLazySingleton(() => LtieService());
  locator.registerLazySingleton(() => HacsService());
  locator.registerLazySingleton(() => ThirdPartyProvider());
  locator.registerLazySingleton(() => WebSocketProvider());
}
