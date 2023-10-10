// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i13;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:iot_app/core/model/BleDevice_model.dart' as _i14;
import 'package:iot_app/ui/views/add_device/add_device_view.dart' as _i6;
import 'package:iot_app/ui/views/blewifi/blewifi_view.dart' as _i8;
import 'package:iot_app/ui/views/blue_connect/blue_connect_view.dart' as _i7;
import 'package:iot_app/ui/views/home/home_view.dart' as _i2;
import 'package:iot_app/ui/views/login/login_view.dart' as _i10;
import 'package:iot_app/ui/views/profile/profile_view.dart' as _i4;
import 'package:iot_app/ui/views/provision/provision_view.dart' as _i9;
import 'package:iot_app/ui/views/setting/setting_view.dart' as _i5;
import 'package:iot_app/ui/views/startup/startup_view.dart' as _i3;
import 'package:iot_app/ui/views/thridparty/thridparty_view.dart' as _i11;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i15;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const profileView = '/profile-view';

  static const settingView = '/setting-view';

  static const addDeviceView = '/add-device-view';

  static const blueConnectView = '/blue-connect-view';

  static const blewifiView = '/blewifi-view';

  static const provisionView = '/provision-view';

  static const loginView = '/login-view';

  static const thridpartyView = '/thridparty-view';

  static const all = <String>{
    homeView,
    startupView,
    profileView,
    settingView,
    addDeviceView,
    blueConnectView,
    blewifiView,
    provisionView,
    loginView,
    thridpartyView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i4.ProfileView,
    ),
    _i1.RouteDef(
      Routes.settingView,
      page: _i5.SettingView,
    ),
    _i1.RouteDef(
      Routes.addDeviceView,
      page: _i6.AddDeviceView,
    ),
    _i1.RouteDef(
      Routes.blueConnectView,
      page: _i7.BlueConnectView,
    ),
    _i1.RouteDef(
      Routes.blewifiView,
      page: _i8.BlewifiView,
    ),
    _i1.RouteDef(
      Routes.provisionView,
      page: _i9.ProvisionView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i10.LoginView,
    ),
    _i1.RouteDef(
      Routes.thridpartyView,
      page: _i11.ThridpartyView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.ProfileView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.ProfileView(),
        settings: data,
      );
    },
    _i5.SettingView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SettingView(),
        settings: data,
      );
    },
    _i6.AddDeviceView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.AddDeviceView(),
        settings: data,
      );
    },
    _i7.BlueConnectView: (data) {
      final args = data.getArgs<BlueConnectViewArguments>(
        orElse: () => const BlueConnectViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.BlueConnectView(key: args.key, argument: args.argument),
        settings: data,
      );
    },
    _i8.BlewifiView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.BlewifiView(),
        settings: data,
      );
    },
    _i9.ProvisionView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ProvisionView(),
        settings: data,
      );
    },
    _i10.LoginView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.LoginView(),
        settings: data,
      );
    },
    _i11.ThridpartyView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.ThridpartyView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class BlueConnectViewArguments {
  const BlueConnectViewArguments({
    this.key,
    this.argument,
  });

  final _i13.Key? key;

  final List<_i14.BleDevice>? argument;

  @override
  String toString() {
    return '{"key": "$key", "argument": "$argument"}';
  }

  @override
  bool operator ==(covariant BlueConnectViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.argument == argument;
  }

  @override
  int get hashCode {
    return key.hashCode ^ argument.hashCode;
  }
}

extension NavigatorStateExtension on _i15.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddDeviceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addDeviceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBlueConnectView({
    _i13.Key? key,
    List<_i14.BleDevice>? argument,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.blueConnectView,
        arguments: BlueConnectViewArguments(key: key, argument: argument),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBlewifiView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.blewifiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProvisionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.provisionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToThridpartyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.thridpartyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddDeviceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addDeviceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBlueConnectView({
    _i13.Key? key,
    List<_i14.BleDevice>? argument,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.blueConnectView,
        arguments: BlueConnectViewArguments(key: key, argument: argument),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBlewifiView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.blewifiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProvisionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.provisionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithThridpartyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.thridpartyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
