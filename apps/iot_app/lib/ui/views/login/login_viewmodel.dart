import 'package:flutter/material.dart';
import 'package:iot_app/app/app.dialogs.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/appConfig.dart';
import 'package:iot_app/core/language_provider.dart';
import 'package:iot_app/core/login_provider.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/login_model.dart';
import 'package:iot_app/core/model/user_model.dart';
import 'package:iot_app/ui/dialogs/message/messageDialogStatus.dart';
import 'package:iot_app/ui/widget/radioGroup_widget.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
// ignore: implementation_imports
import 'package:core/src/helper/helper.dart';

class LoginViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _languageProvider = locator<LanguageProvider>();
  final _navigationService = locator<NavigationService>();
  final _theme = locator<ThemeService>();
  final _auth = locator<LoginProvider>();
  LoginModel loginModel = LoginModel();
  dynamic loginInfo;

  String? language;

  SMITrigger? check;
  SMITrigger? cError;
  SMITrigger? reset;

  bool? isSubmitted;

  CompanyModel companyModel = CompanyModel();
  CompanyInfoModel? companyInfo;
  bool? isLoginSuccess;
  List<Map<String, dynamic>> radioList = [
    {'value': 'en', 'label': 'English'},
    {'value': 'km', 'label': 'ភាសារខ្មែរ'}
  ];
  Map<String, dynamic>? languageSub;
  Future<void> initialize() async {
    companyInfo = await AppPref.getCompanyInfo();
    try {
      Locale locale = await getLocale();
      language = locale.languageCode;
      languageSub =
          radioList.firstWhere((element) => element['value'] == language);
      notifyListeners();
    } catch (e) {}
  }

  void handler(String? value) async {
    language = value!;
  }

  void languageSetting(String? title, BuildContext context) async {
    var _dialog = await _dialogService.showCustomDialog(
      variant: DialogType.newDeviceDialog,
      title: title,
      description: title,
      data: RadioGroupWidget(
        handler: handler,
        language: language,
        radioList: radioList,
      ),
    );
    _dialog?.confirmed ?? false
        ? languageChange(language, context)
        : print("Hello");
  }

  void languageChange(String? language, BuildContext context) async {
    await _languageProvider.setNewLocale(language, context);

    languageSub =
        radioList.firstWhere((element) => element['value'] == language);
    notifyListeners();
  }

  void handleThemechange() {
    _theme.toggleDarkLightTheme();
  }

  void onValue(String? value) {
    loginInfo = null;
    companyModel.companyCode = value ?? '';
    notifyListeners();
  }

  Future loginCompany() async {
    companyModel.appName = AppConfig.appName;
    dynamic isSuccess;

    try {
      isLoginSuccess = true;
      notifyListeners();
      isSuccess = await _auth.companyLogin(companyModel);
      check?.fire();
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      isSubmitted = isSuccess['success'];
      isLoginSuccess = false;
      notifyListeners();
    } catch (e) {
      cError?.fire();
      loginInfo = isSuccess;
      notifyListeners();
    }
    // isSubmitted = false;
    showMessageDialog(isSuccess);

    notifyListeners();
  }

  Future userLogin() async {
    isLoginSuccess = true;
    notifyListeners();
    loginModel.companyCode = companyModel.companyCode;
    var resp = await _auth.userLogin(loginModel);
    showMessageDialog(resp);
  }

  Future dialogShow(MessageDialogStatus status, String? title) async {
    DialogResponse? dialog = await _dialogService.showCustomDialog(
      variant: DialogType.message,
      title: 'Error',
      mainButtonTitle: 'Got it',
      description: title,
      data: status,
    );
    if (dialog?.confirmed ?? false) {
      isLoginSuccess = false;
      notifyListeners();
      print(dialog?.confirmed ?? false);
    }
  }

  void showMessageDialog(var resp) async {
    switch (resp.runtimeType) {
      case LTUnauthorizedError:
        cError?.fire();
        await dialogShow(MessageDialogStatus.error, resp?.message);
        break;
      case UnknownError:
        cError?.fire();
        dialogShow(MessageDialogStatus.warning, resp?.message0);

        break;
      case UserModel:
        check?.fire();
        notifyListeners();
        await Future.delayed(Duration(seconds: 3));
        isLoginSuccess = false;
        _navigationService.pushNamedAndRemoveUntil('/home-view');
        notifyListeners();
        break;
      default:
    }
  }

  void changeCompany() {
    isSubmitted = false;
    notifyListeners();
  }
}
