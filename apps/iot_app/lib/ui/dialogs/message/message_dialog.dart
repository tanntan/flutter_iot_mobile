import 'package:flutter/material.dart';
import 'package:iot_app/ui/common/app_colors.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/dialogs/message/messageDialogStatus.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'message_dialog_model.dart';

const double _graphicSize = 60;

class MessageDialog extends StackedView<MessageDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const MessageDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MessageDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: _BasicDialogContent(request: request, completer: completer));
  }

  @override
  MessageDialogModel viewModelBuilder(BuildContext context) =>
      MessageDialogModel();
}

class _BasicDialogContent extends StatelessWidget {
  const _BasicDialogContent({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);
  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              Subtext(text: request.title ?? ''),
              verticalSpaceSmall,
              Subtext(text: request.description ?? ''),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      child: Subtext(text: request.secondaryButtonTitle),
                    ),
                  TextButton(
                    onPressed: () => completer(DialogResponse(confirmed: true)),
                    child: Subtext(text: request.mainButtonTitle),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: _getStatusColor(request.data),
              child: Icon(
                _getStatusIcon(request.data),
                size: 28,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}

Color _getStatusColor(dynamic customData) {
  switch (customData) {
    case MessageDialogStatus.error:
      return kcRedColor;
    case MessageDialogStatus.warning:
      return kcOrangeColor;
    default:
      return kcPrimaryColor;
  }
}

IconData _getStatusIcon(dynamic regionDialogStatus) {
  switch (regionDialogStatus) {
    case MessageDialogStatus.error:
      return Icons.close;
    case MessageDialogStatus.warning:
      return Icons.warning_amber;
    default:
      return Icons.check;
  }
}
