/**
 * @fileoverview: Defines some useful util methods across GUIs.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @version: 0.0.1
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

/// Converts the given double into an integer, but send it as a string.
String toIntegerString (double float) {
  // Converts it into a string.
  final String doubleAsString = float.toString();
  // Sends final result.
  return (
    doubleAsString.contains('.') ?
    doubleAsString.split('.')[0] : doubleAsString
  );
}

/// Launches others bluetooth device(s) scan in the network.
Future<void> launchBluetoothScan () async {
  // Tries to start others bluetooth discovery.
  try {
    // Calls native java code.
    await AppManifest.backend.invokeMethod("fetchBluetoothDevices");
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
  }
}

/// Sends data from the current application UI to the connected device.
Future<void> sendBluetoothData (String dataToSend) async {
  // Tries to send data to the connected device.
  try {
    // Sends a bluetooth data to the back-end.
    await AppManifest.backend.invokeMethod(
      "sendBluetoothData", <String, String>{"dataToSend": dataToSend}
    );
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
  }
}

/// Establishes connection to the selected device.
Future<void> establishConnection (int deviceIndex) async {
  // Tries to connect to the selected device.
  try {
    // Sends a bluetooth connection request to the back-end.
    await AppManifest.backend.invokeMethod(
      "connectToDevice", <String, String>{
        "deviceIndex": deviceIndex.toString()
      }
    );
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
  }
}

/// Stops established connection to the remote device.
Future<bool> disconnectConnectedDevice () async {
  // Tries to disconnect the connected device.
  try {
    // Calls native java code.
    final dynamic result = await AppManifest.backend.invokeMethod(
      "disconnectDevice"
    );
    // Sends final result as expected type.
    return (result as bool);
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
    // Nothing to send, sorry.
    return false;
  }
}

/// Checks whether the mobile bluetooth is enabled.
Future<bool> isBluetoothEnabled () async {
  // Tries to checks whether the bluetooth is enabled.
  try {
    // Calls native java code.
    final dynamic result = await AppManifest.backend.invokeMethod(
      "isBluetoothEnabled"
    );
    // Sends final result as expected type.
    return (result as bool);
  // An error throw.
  } on PlatformException catch (e) {
    // Prints that error.
    debugPrint("Message: ${e.message}, Stack: ${e.stacktrace}");
    // Nothing to send, sorry.
    return false;
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
