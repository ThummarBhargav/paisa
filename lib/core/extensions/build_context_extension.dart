import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}

extension AppBarHelper on BuildContext {

  AppBar materialYouAppBar(
    String title, {
    List<Widget>? actions,
    Widget? leadingWidget,
  }) {
    return AppBar(
      toolbarHeight: 110,
      leading: leadingWidget,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: Text(title),
      titleTextStyle: appTheme.normalText(22),
      actions: actions ?? [],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.04, -1.00),
            end: Alignment(-0.04, 1),
            colors: [Color(0xFF6A14F3), Color(0xFF863AFF)],
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMaterialSnackBar(String content, {
    Color? backgroundColor,
    Color? color,
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          content,
          style: TextStyle(
            color: color ?? onSurfaceVariant,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? surfaceVariant,
        action: action,
      ),
    );
  }
}