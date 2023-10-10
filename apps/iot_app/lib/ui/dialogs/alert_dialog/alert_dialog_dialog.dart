import 'package:flutter/material.dart';
import 'package:iot_app/ui/common/app_colors.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'alert_dialog_dialog_model.dart';

const double _graphicSize = 60;

class AlertDialogDialog extends StackedView<AlertDialogDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AlertDialogDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AlertDialogDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: RiveAnimation.asset('assets/question.riv'),
                      ),
                      Text(
                        request.title ?? 'Hello Stacked Dialog!!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      if (request.data != null) ...[
                        request.data,
                      ],
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => completer(DialogResponse(confirmed: false)),
                  child: Container(
                    height: 50,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      translate(context).ksCancel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                GestureDetector(
                  onTap: () => completer(DialogResponse(confirmed: true)),
                  child: Container(
                    height: 50,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      translate(context).ksDiscard,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  AlertDialogDialogModel viewModelBuilder(BuildContext context) =>
      AlertDialogDialogModel();
}
