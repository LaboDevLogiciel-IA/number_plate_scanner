/**
 * @fileoverview: Represents application main process or entry point.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-02-09
 * @updated: 2026-02-09
 * @file: main.dart
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "./src/globals/constants/manifest.dart";
import "./src/features/splash.dart";

/// Called when application started.
void main () async {
  // Starts application interface.
  runApp(Rapi());
}

/// Application root view. It's the entry point of [Rapi].
class Rapi extends StatelessWidget {
  /// Initializes the **[Key]** and calls its parent constructor.
  /// The **[Key]** represents the unique id to identify this view.
  const Rapi ({super.key});

  /// Called when the state is ready and at all times where it mutates.
  ///
  /// When the user interface is ready, it generates its own *[context]*
  /// that represent the state's [BuildContext] bound to its activity.
  @override
  MaterialApp build (BuildContext _) => MaterialApp(
    theme: AppManifest.activeTheme.getTheme(),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    title: "RAPI"
  );
}
