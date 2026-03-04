/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Application home screen.
 * @supported: ANDROID & IOS
 * @created: 2026-01-13
 * @updated: 2026-03-04
 * @file: home.dart
 * @version: 0.0.3
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// Plugin dependencies.
import "package:permission_handler/permission_handler.dart";

/// Custom dependencies.
import "../globals/dialogs/centered_modal.dart";
import "../globals/dialogs/ios_popup.dart";
import "../globals/constants/images.dart";
import "../globals/constants/fonts.dart";
import "../globals/widgets/button.dart";
import "../globals/widgets/image.dart";
import "../globals/widgets/label.dart";
import "../globals/utils/std.dart";

/// Manages application home view logic.
@immutable
class HomeScreen extends StatefulWidget {
  /// Initializes [key] and calls his parent constructor.
  /// The [Key] represents unique id to identify this view.
  const HomeScreen ({super.key});

  /// Creates a new object instance of his state. The state
  /// represents all different necessaries [widgets] to
  /// render graphically.
  @override
  State<HomeScreen> createState () => _HomeScreenState();

  /// Asks all required permissions.
  Future<void> askPermissions () async {
    // Waiting for 02 seconds.
    await Future.delayed(
      Duration(seconds: 2),
      () async => await <Permission>[Permission.location].request()
    );
  }

  /// Displays a confirm dialog box for quit operator.
  Future<void> quitApp (BuildContext context) async {
    // Shows a custom dialog box for operation confirmation.
    await showIosPopup(
      options: <String>[lang.getText("cancel"), lang.getText("quit")],
      active: <String>[lang.getText("quit")],
      message: lang.getText("quitMessage"),
      context: context,
      onTap: (int option) async {
        // Whether `quit` is pressed.
        if (option == 1) SystemNavigator.pop();
      }
    );
  }
}

/// Represents application home page view.
class _HomeScreenState extends State<HomeScreen> {
  /// Called when this activity is mounted into tree.
  ///
  /// Notice that, [initState] method is called once only.
  /// If you mutate state, this method won't call again.
  @override
  void initState () {
    // Calls parent init state method.
    super.initState();
    // Asks for required permissions.
    widget.askPermissions();
    // Uses portrait orientation only.
    usePortraitModeOnly();
  }

  /// Builds header to display all helpful data for bluetooth.
  AppBar drawHeader () => AppBar(
    shadowColor: Theme.of(context).cardTheme.surfaceTintColor,
    backgroundColor: Theme.of(context).primaryColorDark,
    scrolledUnderElevation: 4,
    titleSpacing: 0,
    elevation: 4,
    leading: Icon(
      Icons.home,
      color: Theme.of(context).dialogTheme.backgroundColor
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: Brightness.light
    ),
    title: Label(
      text: lang.getText("home"),
      style: TextStyle(
        color: Theme.of(context).dialogTheme.backgroundColor,
        fontFamily: AppFonts.sanFrancisco,
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      )
    ),
    actions: <IconButton>[
      // Settings icon.
      IconButton(
        onPressed: () async => await displaySettings(),
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).dialogTheme.backgroundColor
        )
      )
    ]
  );

  /// Displays in a modal and input to allow user to put api link.
  Future<void> displaySettings () async {
    // Input text field controller.
    final TextEditingController apiLink = TextEditingController();
    // Shows a custom centered popup.
    await showCenteredModal(
      title: lang.getText("settings"),
      messageType: MessageType.none,
      context: context,
      text: null,
      options: configureOptions(
        options: <String>[lang.getText("cancel"), lang.getText("save")],
        optionsAlignment: OptionsAlignment.auto,
        active: <String>[lang.getText("save")],
        context: context,
        onTap: (int option) {
          // Whether `cancel` option is tapped.
          if (option == 0) {
            debugPrint("Cancel!");
          // Whether `save` option is tapped.
          } else if (option == 1) {
            debugPrint("Save!");
          }
        }
      ),
      content: Padding(
        padding: EdgeInsets.only(
          bottom: 12.0, right: 16.0, left: 16.0, top: 10.0
        ),
        child: Column(
          children: <Widget> [
            // Input content description.
            Label(
              text: lang.getText("settingsMessage"),
              align: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).cardTheme.surfaceTintColor,
                fontFamily: AppFonts.sanFrancisco,
                fontSize: 14.0
              )
            ),
            // Bottom margin.
            SizedBox(height: 8.0),
            // Input text field (API link).
            TextField(
              controller: apiLink,
              autocorrect: false,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontFamily: AppFonts.sanFrancisco,
                fontSize: 14.0
              ),
              decoration: InputDecoration(
                fillColor: Theme.of(context).dialogTheme.surfaceTintColor,
                hintText: lang.getText("apiLink"),
                isDense: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 8.0
                ),
                hintStyle: TextStyle(
                  color: Theme.of(context).dividerColor,
                  fontFamily: AppFonts.sanFrancisco,
                  fontSize: 14.0
                )
              )
            )
          ]
        )
      )
    );
  }

  /// Called when state is ready and at all time state will mutate.
  ///
  /// When view is ready, it generates its own [context] that represent
  /// state's [BuildContext] bound to its activity. [build] method will
  /// call at every time if and only if [setState] method is called
  /// within a program.
  @override
  PopScope build (BuildContext context) => PopScope(
    canPop: false,
    // Called when android back button is pressed.
    onPopInvokedWithResult: (
      bool a, dynamic b
    ) async => await widget.quitApp(context),
    // Content structure.
    child: Scaffold(
      backgroundColor: Theme.of(context).dialogTheme.surfaceTintColor,
      appBar: drawHeader(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            // Global structure.
            child: Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width < 321.0 ? 16.0 : 22.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // License plate scan image.
                  ImageIconLogoDisplayer(
                    path: AppImagesPaths.scan,
                    disabled: true,
                    height: 148,
                    width: 148
                  ),
                  // Bottom margin.
                  SizedBox(height: 16.0),
                  // Tutorial title.
                  Label(
                    text: lang.getText("tutorialTitle"),
                    align: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).cardTheme.surfaceTintColor,
                      fontFamily: AppFonts.sanFrancisco,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )
                  ),
                  // Bottom margin.
                  SizedBox(height: 4.0),
                  // Tutorial description.
                  Label(
                    text: lang.getText("tutorialMessage"),
                    align: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).cardTheme.shadowColor,
                      fontFamily: AppFonts.sanFrancisco,
                      fontSize: 14.0
                    )
                  ),
                  // Bottom margin.
                  SizedBox(height: 28.0),
                  // Start camera.
                  Button(
                    textColor: Theme.of(context).dialogTheme.backgroundColor!,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    radius: BorderRadius.all(Radius.circular(32.0)),
                    text: lang.getText("startCamera"),
                    width: 176.0,
                    leftIcon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      size: 18.0
                    )
                  ),
                  // Bottom margin.
                  SizedBox(height: 24.0),
                  // Load image from gallery.
                  Button(
                    textColor: Theme.of(context).dialogTheme.backgroundColor!,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    radius: BorderRadius.all(Radius.circular(32.0)),
                    text: lang.getText("loadImage"),
                    width: 176.0,
                    leftIcon: Icon(
                      Icons.image,
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      size: 18.0
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    )
  );
}
