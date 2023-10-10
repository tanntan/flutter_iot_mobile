import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const PasswordFormField(
      {Key? key, required this.initialValue, this.onChanged, this.onSaved})
      : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isObscureText,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        validator: (value) {
          if (value?.isNotEmpty == true && value!.length < 8) {
            return 'The minimum password length is 8';
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: TextButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                    isObscureText ? Icons.remove_red_eye : Icons.lock_outline,
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1,
                ))));
  }
}
