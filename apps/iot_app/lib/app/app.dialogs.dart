// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/alert_dialog/alert_dialog_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/message/message_dialog.dart';
import '../ui/dialogs/new_device_dialog/new_device_dialog_dialog.dart';

enum DialogType {
  infoAlert,
  newDeviceDialog,
  alertDialog,
  message,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.newDeviceDialog: (context, request, completer) =>
        NewDeviceDialogDialog(request: request, completer: completer),
    DialogType.alertDialog: (context, request, completer) =>
        AlertDialogDialog(request: request, completer: completer),
    DialogType.message: (context, request, completer) =>
        MessageDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
