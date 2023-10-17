import 'package:iot_app/app/app.locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:iot_app/services/theme_service.dart';
import 'package:iot_app/services/ble_service.dart';
import 'package:iot_app/services/companylogin_service.dart';
import 'package:iot_app/services/globaladmin_service.dart';
import 'package:iot_app/services/iotapi_service.dart';
import 'package:iot_app/services/ltie_service.dart';
import 'package:iot_app/services/hacs_service.dart';

import 'test_helpers.mocks.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BleService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GlobaladminService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CompanyLoginService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<IotapiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<LtieService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HacsService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterThemeService();
  getAndRegisterBleService();
  getAndRegisterBleService();
  getAndRegisterGlobaladminService();
  getAndRegisterCompanyloginService();
  getAndRegisterGlobaladminService();

  getAndRegisterCompanyloginService();
  getAndRegisterCompanyLoginService();
  getAndRegisterIotapiService();
  getAndRegisterLtieService();
  getAndRegisterHacsService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockThemeService getAndRegisterThemeService() {
  _removeRegistrationIfExists<ThemeService>();
  final service = MockThemeService();
  locator.registerSingleton<ThemeService>(service);
  return service;
}

MockBleService getAndRegisterBleService() {
  _removeRegistrationIfExists<BleService>();
  final service = MockBleService();
  locator.registerSingleton<BleService>(service);
  return service;
}

MockCompanyLoginService getAndRegisterCompanyloginService() {
  _removeRegistrationIfExists<CompanyLoginService>();
  final service = MockCompanyLoginService();
  locator.registerSingleton<CompanyLoginService>(service);
  return service;
}

MockGlobaladminService getAndRegisterGlobaladminService() {
  _removeRegistrationIfExists<GlobaladminService>();
  final service = MockGlobaladminService();
  locator.registerSingleton<GlobaladminService>(service);
  return service;
}

MockCompanyLoginService getAndRegisterCompanyLoginService() {
  _removeRegistrationIfExists<CompanyLoginService>();
  final service = MockCompanyLoginService();
  locator.registerSingleton<CompanyLoginService>(service);
  return service;
}

MockIotapiService getAndRegisterIotapiService() {
  _removeRegistrationIfExists<IotapiService>();
  final service = MockIotapiService();
  locator.registerSingleton<IotapiService>(service);
  return service;
}

MockLtieService getAndRegisterLtieService() {
  _removeRegistrationIfExists<LtieService>();
  final service = MockLtieService();
  locator.registerSingleton<LtieService>(service);
  return service;
}

MockHacsService getAndRegisterHacsService() {
  _removeRegistrationIfExists<HacsService>();
  final service = MockHacsService();
  locator.registerSingleton<HacsService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
