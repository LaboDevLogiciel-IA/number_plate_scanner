/**
 * @fileoverview: Defines some useful util methods across GUIs.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-16
 * @version: 0.0.3
 * @file: std.dart
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// Custom dependencies.
import "../animations/animated_double.dart";
import "../constants/manifest.dart";
import "../models/language.dart";

/// Global attributes.
final ThemeData? theme = AppManifest.activeTheme.getTheme();
final Language lang = AppManifest.activeLanguage;

/// Changes app status and navigation bar color.
void overrideBarColors () {
  // Overrides status color.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: theme!.primaryColor,
      statusBarColor: theme!.primaryColor
    )
  );
}

/// Converts given double into an integer, but send it as a string.
String toIntegerString (double float) {
  // Converts it into a string.
  final String doubleAsString = float.toString();
  // Sends final result.
  return (
    doubleAsString.contains('.') ?
    doubleAsString.split('.')[0] : doubleAsString
  );
}

/// Makes active app activity be portrait mode.
void usePortraitModeOnly () {
  // Overrides bar colors.
  overrideBarColors();
  // Uses portrait orientation only.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
}

/// Saves api link to mobile preferences.
Future<void> saveApiLink (String apiLink) async {
  // Tries to save that api link to mobile preferences.
  try {
    // Calls native java code.
    await AppManifest.backend.invokeMethod(
      "saveApiLinkToPreferences", <String, String>{"newApiLink": apiLink}
    );
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
  }
}

/// Fetches api link value from mobile preferences.
Future<String?> fetchApiLink () async {
  // Tries to get saved api link from preferences.
  try {
    // Gets last saved api link from preferences.
    return await AppManifest.backend.invokeMethod<String?>(
      "loadApiLinkFromPreferences"
    );
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
    // Nothing found.
    return null;
  }
}

/// Applies an interactive click animation effect on every
/// carousel sub items.
AnimatedDouble animatedTap (
  Widget child,
  {
    required BorderRadius borderRadius,
    void Function()? onCompleted,
    bool isAnimated = false,
    bool disabled = false,
    double end = 0.2
  }
) => AnimatedDouble(
  direction: AnimationDirection.alternate,
  iterationCount: (!isAnimated ? 1 : 3),
  duration: (!isAnimated ? 0 : 34),
  end: (!isAnimated ? 0.0 : end),
  onCompleted: onCompleted,
  isDisabled: disabled,
  start: 0.0,
  builder: (double value, BuildContext context) => Stack(
    children: <Widget>[
      child,
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Color.fromRGBO(
              ((Theme.of(context).primaryColor.r * 255.0).round() & 0xFF),
              ((Theme.of(context).primaryColor.g * 255.0).round() & 0xFF),
              ((Theme.of(context).primaryColor.b * 255.0).round() & 0xFF),
              value
            )
          )
        )
      )
    ]
  )
);
