import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iot_app/app/app.bottomsheets.dart';
import 'package:iot_app/app/app.dialogs.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/app/app.router.dart';
import 'package:iot_app/setup_provider.dart';
import 'package:iot_app/ui/theme_setup.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await ThemeManager.initialise();
  setupDialogUi();
  setupBottomSheetUi();
  AppPref.initPref();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static void setlocale(BuildContext context, Locale newlocale) async {
    _MainAppState state = context.findAncestorStateOfType<_MainAppState>()!;
    state.setNewlocale(newlocale);
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;
  void setNewlocale(Locale? newlocale) {
    setState(() {
      _locale = newlocale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setNewlocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      lightTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      builder: (context, regularTheme, darkTheme, themeMode) => MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: regularTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          builder: (BuildContext context, Widget? child) {
            EasyLoading.init();
            return Container(child: child);
          },
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
        ),
      ),
    );
  }
}
