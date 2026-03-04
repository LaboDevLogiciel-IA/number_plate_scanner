/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: The splash screen.
 * @supported: ANDROID & IOS
 * @created: 2026-01-13
 * @updated: 2026-03-04
 * @file: splash.dart
 * @version: 0.0.3
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "../globals/constants/fonts.dart";
import "../globals/constants/logos.dart";
import "../globals/widgets/image.dart";
import "../globals/widgets/label.dart";
import "../globals/utils/std.dart";
import "./home.dart";

/// Builds application splash screen view.
@immutable
class SplashScreen extends StatefulWidget {
  /// Initializes [key] and calls his parent constructor.
  ///
  /// [Key] represents unique id to identify this view.
  const SplashScreen ({super.key});

  /// Creates a new object instance of his state. The state
  /// represents all different necessaries [widgets] to
  /// render graphically.
  @override
  State<SplashScreen> createState () => _SplashScreenState();

  /// Erases active screen and opens home page after wait for
  /// (06) seconds.
  Future<void> goToHomePage (BuildContext context) async {
    // Waiting for (06) seconds before go to home page.
    await Future.delayed(Duration(seconds: 6), () async {
      // Whether context is mounted.
      if (!context.mounted) return;
      // Loads and opens home page.
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext _) => HomeScreen())
      );
    });
  }
}

/// Represents splash screen state ([widgets]).
///
/// It's there, we draw all useful [widgets]
/// to build splash screen graphically.
class _SplashScreenState extends State<SplashScreen> {
  /// Called when this activity is mounted into tree.
  ///
  /// Notice that, [initState] method is called once
  /// only. If you mutate state, this method won't
  /// call again.
  @override
  void initState () {
    // Calls parent init state method.
    super.initState();
    // Goes to home page after checks language possibilities.
    widget.goToHomePage(context);
    // Uses portrait orientation only.
    usePortraitModeOnly();
  }

  /// Called when state is ready and at all time state will mutate.
  ///
  /// When view is ready, it generates its own [context] that represent
  /// state's [BuildContext] bound to its activity. [build] method
  /// will call at every time if and only if [setState] method is
  /// called within a program.
  @override
  PopScope build (BuildContext context) => PopScope(
    // Called when user press android back button.
    canPop: false,
    child: Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      bottomNavigationBar: SizedBox(
        height: (MediaQuery.of(context).size.width < 321.0 ? 64.0 : 72.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Organization maker.
            Label(
              text: lang.getText("copyright"),
              style: TextStyle(
                color: Theme.of(context).dialogTheme.surfaceTintColor,
                fontFamily: AppFonts.sanFrancisco,
                fontSize: 14.0
              )
            )
          ]
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: <Color>[
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark
            ]
          )
        ),
        child: SingleChildScrollView(
          // Global structure.
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              // Components structure.
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Makes a little top margin.
                SizedBox(height: 64.0),
                // Application logo image.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Makes a little left margin.
                    SizedBox(width: 14.0),
                    // Vector representation.
                    ImageIconLogoDisplayer(
                      path: AppLogosPaths.appLogo,
                      disabled: true,
                      height: 180.0,
                      width: 180.0
                    )
                  ]
                ),
                // Makes a little top margin.
                SizedBox(height: 16.0),
                // Application name.
                Label(
                  text: lang.getText("appName"),
                  style: TextStyle(
                    color: Theme.of(context).dialogTheme.surfaceTintColor,
                    fontFamily: AppFonts.sanFrancisco,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0
                  )
                ),
                // Makes a little top margin.
                SizedBox(height: 8.0),
                // Application information.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Label(
                      text: lang.getText("appVersion"),
                      style: TextStyle(
                        color: Theme.of(context).dialogTheme.surfaceTintColor,
                        fontFamily: AppFonts.sanFrancisco,
                        fontSize: 14.0
                      )
                    )
                  ]
                ),
                // Makes a little top margin.
                SizedBox(height: (
                  MediaQuery.of(context).size.width < 321.0 ? 32.0 : 48.0
                )),
                // Infinite loader.
                CircularProgressIndicator(
                  color: Theme.of(context).dialogTheme.surfaceTintColor,
                  strokeWidth: 2.0
                )
              ]
            )
          )
        )
      )
    )
  );
}
