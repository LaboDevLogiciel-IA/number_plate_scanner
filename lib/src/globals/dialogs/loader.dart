/**
 * @fileoverview: Defines a global dialog for displaying a loader popup.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: loader.dart
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "../extensions/string.dart";
import "../constants/fonts.dart";
import "../widgets/label.dart";

/// Builds a loader with the given data. [onReady] is called when the
/// given [delay] for display the loader is over. Notice that is case
/// is treated if _[infinite]_ field is set to `false`.
Future<void> showLoader ({
  Duration delay = const Duration(seconds: 1),
  required BuildContext context,
  void Function()? onReady,
  bool isClosable = false,
  bool infinite = false,
  String? title
}) async {
  // The given title.
  title = title?.getFilledString();
  // Whether a delay is specified.
  if (!infinite) {
    // Waiting for the given delay.
    Future.delayed(delay, () {
      // Destroys the loader from the app view.
      if (context.mounted) Navigator.pop(context);
      // Whether the passed method reference when loader is ready.
      if (onReady != null) onReady();
    });
  }
  // Creates a popup loader for the final rendering.
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => PopScope(
      canPop: isClosable,
      child: Dialog(
        insetPadding: EdgeInsets.only(right: 64.0, left: 64.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Makes a little top margin.
              SizedBox(height: 15.0),
              // Loader logo.
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).dialogTheme.iconColor,
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor
                )
              ),
              // Bottom content.
              if (title != null) Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Makes a little top margin.
                  SizedBox(height: 15.0),
                  // Modal loader bottom title.
                  Label(
                    align: TextAlign.center,
                    text: "$title...",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                      fontFamily: AppFonts.sanFrancisco,
                      fontSize: 16.0
                    )
                  )
                ]
              ),
              // Makes a little bottom margin.
              SizedBox(height: 15.0)
            ]
          )
        )
      )
    )
  );
}
