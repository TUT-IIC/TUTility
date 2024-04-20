import 'package:flutter/material.dart';

@immutable
class _AlertDialog extends StatelessWidget {
  final String message;

  const _AlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

@immutable
class _ConfirmDialog extends StatelessWidget {
  final String message;
  final void Function()? onOk;
  final void Function()? onCancel;

  const _ConfirmDialog({
    required this.message,
    this.onOk,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          child: Text(localizations.cancelButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
        ),
        TextButton(
          child: Text(localizations.okButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
            onOk?.call();
          },
        ),
      ],
    );
  }
}

Future<T?> showAlertDialog<T>({
  required BuildContext context,
  required String message,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => _AlertDialog(message: message),
    );

Future<T?> showConfirmDialog<T>({
  required BuildContext context,
  required String message,
  void Function()? onOk,
  void Function()? onCancel,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => _ConfirmDialog(
        message: message,
        onOk: onOk,
        onCancel: onCancel,
      ),
    );
