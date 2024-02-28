import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';

enum UserMenuPopup { debts, chooseTheme, settings, userDetails }

Future<void> paisaBottomSheet(
  BuildContext context,
  Widget child,
) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: child,
        ),
      ),
    ),
  );
}

Future<T?> PaisaAlertDialog<T>(BuildContext context, {
  required Widget child,
  required Widget title,
  required Widget confirmationButton,
  required Widget cancelButton,
  required TextStyle? titleTextStyle,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      titleTextStyle: titleTextStyle,
      title: title,
      content: child,
      actions: [
        cancelButton,
        confirmationButton,
      ],
    ),
  );
}