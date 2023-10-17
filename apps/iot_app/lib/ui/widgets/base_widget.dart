import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  const BaseWidget({
    Key? key,
    required this.builder,
    required this.onModelReader,
    required this.viewModel,
  }) : super(key: key);

  final Widget Function(BuildContext) builder;
  final Function(T) onModelReader;
  final T viewModel;

  @override
  // ignore: library_private_types_in_public_api
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T _model;
  @override
  void initState() {
    super.initState();
    _model = widget.viewModel;

    widget.onModelReader(_model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _model,
      child: widget.builder(context),
    );
  }
}
