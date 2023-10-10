import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/ble_provider.dart';
import 'package:iot_app/core/iotapi_provider.dart';
import 'package:iot_app/core/language_provider.dart';
import 'package:iot_app/core/login_provider.dart';
import 'package:iot_app/core/ltie_provider.dart';
import 'package:iot_app/core/thirdparty_provider.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => locator<LanguageProvider>()),
  ChangeNotifierProvider(create: (_) => locator<BleProvider>()),
  ChangeNotifierProvider(create: (_) => locator<LoginProvider>()),
  ChangeNotifierProvider(create: (_) => locator<IotApiProvider>()),
  ChangeNotifierProvider(create: (_) => locator<LtieProvider>()),
  ChangeNotifierProvider(create: (_) => locator<ThirdPartyProvider>()),
  ChangeNotifierProvider(create: (_) => locator<WebSocketProvider>())
];
