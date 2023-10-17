import 'package:iot_app/core/ble_provider.dart';
import 'package:iot_app/core/iotapi_provider.dart';
import 'package:iot_app/core/language_provider.dart';
import 'package:iot_app/core/login_provider.dart';
import 'package:iot_app/core/ltie_provider.dart';
import 'package:iot_app/core/thirdparty_provider.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:iot_app/services/companylogin_service.dart';
import 'package:iot_app/services/hacs_service.dart';
import 'package:iot_app/services/iotapi_service.dart';
import 'package:iot_app/services/ltie_service.dart';
import 'package:iot_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:iot_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:iot_app/ui/dialogs/menu/menu_dialog.dart';
import 'package:iot_app/ui/dialogs/message/message_dialog.dart';
import 'package:iot_app/ui/views/devices/devices_view.dart';
import 'package:iot_app/ui/views/home/home_view.dart';
import 'package:iot_app/ui/views/startup/startup_view.dart';
import 'package:iot_app/ui/views/thridparty/thridparty_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:iot_app/ui/dialogs/new_device_dialog/new_device_dialog_dialog.dart';
import 'package:iot_app/ui/views/profile/profile_view.dart';
import 'package:iot_app/ui/views/setting/setting_view.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:iot_app/ui/views/devices/add_device/add_device_view.dart';
import 'package:iot_app/ui/views/devices/blue_connect/blue_connect_view.dart';
import 'package:iot_app/services/ble_service.dart';
import 'package:iot_app/ui/views/devices/blewifi/blewifi_view.dart';
import 'package:iot_app/ui/dialogs/alert_dialog/alert_dialog_dialog.dart';
import 'package:iot_app/ui/views/devices/provision/provision_view.dart';
import 'package:iot_app/ui/views/login/login_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingView),
    MaterialRoute(page: AddDeviceView),
    MaterialRoute(page: BlueConnectView),
    MaterialRoute(page: BlewifiView),
    MaterialRoute(page: ProvisionView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ThridpartyView),
    MaterialRoute(page: DevicesView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(
        resolveUsing: ThemeService.getInstance, classType: ThemeService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LanguageProvider),
    LazySingleton(classType: BleProvider),
    LazySingleton(classType: BleService),
    LazySingleton(classType: LoginProvider),
    LazySingleton(classType: CompanyLoginService),
    LazySingleton(classType: IotapiService),
    LazySingleton(classType: IotApiProvider),
    LazySingleton(classType: LtieProvider),
    LazySingleton(classType: LtieService),
    LazySingleton(classType: HacsService),
    LazySingleton(classType: ThirdPartyProvider),
    LazySingleton(classType: WebSocketProvider),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: NewDeviceDialogDialog),
    StackedDialog(classType: AlertDialogDialog),
    StackedDialog(classType: MessageDialog),
    StackedDialog(classType: MenuDialog),
// @stacked-dialog
  ],
)
class App {}
