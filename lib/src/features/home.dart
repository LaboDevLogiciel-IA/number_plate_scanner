/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Application home screen.
 * @supported: ANDROID & IOS
 * @created: 2026-01-13
 * @updated: 2026-03-23
 * @file: home.dart
 * @version: 0.0.6
 */

/// Dart dependencies.
library;
import "dart:ui" as ui;
import "dart:io";

/// Flutter dependencies.
import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// Plugin dependencies.
import "package:permission_handler/permission_handler.dart";
import "package:image_picker/image_picker.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:http/http.dart";

/// Custom dependencies.
import "../globals/dialogs/centered_modal.dart";
import "../globals/dialogs/ios_popup.dart";
import "../globals/constants/images.dart";
import "../globals/constants/fonts.dart";
import "../globals/widgets/button.dart";
import "../globals/dialogs/loader.dart";
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
  /// Attributes.
  final ImagePicker picker = ImagePicker();
  bool isTransferView = false;
  String resolution = "--";
  File? selectedImage;
  String time = "--";
  String date = "--";
  String size = "--";

  /// Sends image resolution.
  Future<String> getImageResolution (File image) async {
    // Gets image as bytes.
    final Uint8List bytes = await File(image.path).readAsBytes();
    // Decodes image to get real dimensions.
    final ui.Image decoded = await decodeImageFromList(bytes);
    // Sends resolution as string.
    return "${decoded.width}pixels x ${decoded.height}pixels";
  }

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

  /// Sends image size.
  Future<String> getImageSize (File image) async {
    // Gets image size.
    final int bytes = await image.length();
    // Computes size for mega bytes.
    final int mbSize = (1024 * 1024);
    // Whether image is too tiny.
    if (bytes < 1024) return "$bytes B";
    // Whether image is medium size.
    if (bytes < mbSize) return "${(bytes / 1024).toStringAsFixed(2)} KB";
    // Whether image is too large.
    return "${(bytes / mbSize).toStringAsFixed(2)} MB";
  }

  /// Gets actual time.
  String getCurrentTime () {
    // Gets current date and time.
    final DateTime now = DateTime.now();
    // Gets current minute as string format.
    final String minute = now.minute.toString().padLeft(2, '0');
    // Gets current second as string format.
    final String second = now.second.toString().padLeft(2, '0');
    // Gets current hour as string format.
    final String hour = now.hour.toString().padLeft(2, '0');
    // Sends final result.
    return "${hour}h/${minute}m/${second}s";
  }

  /// Gets actual date.
  String getCurrentDate () {
    // Gets current date and time.
    final DateTime now = DateTime.now();
    // Gets current month as string format.
    final String month = now.month.toString().padLeft(2, '0');
    // Gets current day as string format.
    final String day = now.day.toString().padLeft(2, '0');
    // Gets current year as string format.
    final String year = now.year.toString();
    // Sends final result.
    return "$day/$month/$year";
  }

  /// Saves api link to mobile local preferences.
  Future<void> saveToPrefs (int option, String link) async {
    // Whether another option is tapped.
    if (option != 1) return;
    // Saves API link to preferences.
    saveApiLink(link);
    // Displays a toast.
    Fluttertoast.showToast(
      backgroundColor: Theme.of(context).cardTheme.surfaceTintColor,
      textColor: Theme.of(context).dialogTheme.surfaceTintColor,
      msg: lang.getText("settingsSaveSuccess"),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0
    );
  }

  /// Called when android back button is pressed.
  Future<void> onBackButtonPressed (bool a, dynamic b) async {
    // Whether we aren't under transfert view.
    if (!isTransferView) {
      // Launches app exit process.
      await widget.quitApp(context);
    // Otherwise.
    } else {
      // Resets transfer view state.
      isTransferView = false;
      // Resets selected image.
      selectedImage = null;
      // Resets image resolution.
      resolution = "--";
      // Resets upload time.
      time = "--";
      // Resets upload date.
      date = "--";
      // Resets image weight.
      size = "--";
      // Comeback to home screen before.
      setState(() => {});
    }
  }

  /// Picks an image from mobile native gallery.
  Future<void> pickFromGallery () async {
    // Opens gallery to select an image.
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery, imageQuality: 80
    );
    // Whether no image was really selected.
    if (image == null) {
      // Whether context isn't mounted.
      if (!mounted) return;
      // Invalid image or damage.
      await showIosPopup(
        message: lang.getText("loadErrorMessage"),
        options: <String>[lang.getText("ok")],
        title: lang.getText("loadErrorTitle"),
        active: <String>[lang.getText("ok")],
        context: context
      );
    // Otherwise.
    } else {
      // The fresh loaded image file.
      final File loadedImage = File(image.path);
      // Gets image resolution.
      resolution = await getImageResolution(loadedImage);
      // Gets image weight.
      size = await getImageSize(loadedImage);
      // Gets selected image file.
      selectedImage = loadedImage;
      // Gets current time.
      time = getCurrentTime();
      // Gets current date.
      date = getCurrentDate();
      // Goes to transfer view.
      isTransferView = true;
      // Updates view data.
      setState(() => {});
    }
  }

  /// Returns configured api link regardless all possibles cases.
  Future<String> getConfiguredAPILink () async {
    // Gets api link from preferences.
    final String link = (await fetchApiLink() ?? '');
    // Regex for `.com/`, `.net/`, `.ai/`, etc...
    final RegExp reg3 = RegExp(r".*\.[a-z]{2,}/$");
    // Regex for `.com`, `.net`, `.ai`, etc...
    final RegExp reg2 = RegExp(r"\.[a-z]{2,}$");
    // Whether no link found.
    if (link.isEmpty) return '';
    // Regex for remote api link.
    final RegExp reg1 = RegExp(
      r"^https?://[a-z\d\-_.]+\.[a-z]{2,}(/[a-z\d\-_]+)*/?$"
    );
    // Whether it's not an online host.
    if (!reg1.hasMatch(link)) {
      // Gets api link parts.
      final List<String> parts = (link.contains(':') ? link.split(':') : []);
      // Whether there are no parts.
      if (parts.isEmpty) {return "http://$link:8080/api/v1/upload/";}
      // Whether we found port number.
      else if (parts.length == 2) {return "http://$link/api/v1/upload/";}
      // Otherwise.
      else {return link;}
    // Otherwise.
    } else {
      // Whether link ends with `/api/v1`.
      if (link.endsWith("/api/v1")) {return "$link/upload/";}
      // Whether link ends with `/api/v1/`.
      else if (link.endsWith("/api/v1/")) {return "${link}upload/";}
      // Whether link ends with `/api/v1/upload`.
      else if (link.endsWith("/api/v1/upload")) {return "$link/";}
      // Whether link ends with `.com`, `.net`, `.ai`, etc...
      else if (reg2.hasMatch(link)) {return "$link/api/v1/upload/";}
      // Whether link ends with `.com/`, `.net/`, `.ai/`, etc...
      else if (reg3.hasMatch(link)) {return "${link}api/v1/upload/";}
      // Unexpected cases.
      else {return link;}
    }
  }

  /// Builds and draws loaded image data.
  Column buildDetailRow (String tagName, String value) => Column(
    children: <Widget>[
      // Line data.
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Tag or key name.
          Label(
            align: TextAlign.left,
            text: tagName,
            style: TextStyle(
              color: Theme.of(context).cardTheme.surfaceTintColor,
              fontFamily: AppFonts.sanFrancisco,
              fontWeight: FontWeight.bold,
              fontSize: 14.0
            )
          ),
          // Value associated.
          Label(
            align: TextAlign.right,
            text: value,
            style: TextStyle(
              color: Theme.of(context).cardTheme.surfaceTintColor,
              fontFamily: AppFonts.sanFrancisco,
              fontWeight: FontWeight.bold,
              fontSize: 14.0
            )
          )
        ]
      ),
      // Bottom margin.
      SizedBox(height: 8.0),
      // Bottom line.
      Divider(
        color: Theme.of(context).cardTheme.color,
        thickness: 1.0, height: 1.0
      )
    ]
  );

  /// Builds header to display all helpful data for home screen.
  AppBar drawHeader () => AppBar(
    shadowColor: Theme.of(context).cardTheme.surfaceTintColor,
    backgroundColor: Theme.of(context).primaryColorDark,
    scrolledUnderElevation: 4,
    titleSpacing: 0,
    elevation: 4,
    leading: IconButton(
      icon: Icon(
        (isTransferView ? Icons.arrow_back : Icons.home),
        color: Theme.of(context).dialogTheme.backgroundColor
      ),
      onPressed: (
        !isTransferView ? null :
        () => setState(() => isTransferView = false)
      )
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: Brightness.light
    ),
    title: Label(
      text: lang.getText(isTransferView ? "transfer" : "home"),
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

  /// Builds home section view.
  Column buildHomeSection () => Column(
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
        onTap: (Object? _) async => await pickFromGallery(),
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
  );

  /// Displays in a modal and input to allow user to put api link.
  Future<void> displaySettings () async {
    // Input text field controller.
    final TextEditingController apiLink = TextEditingController();
    // Loads last saved api link whether possible.
    apiLink.text = (await fetchApiLink() ?? '');
    // Whether context isn't mounted.
    if (!mounted) return;
    // Shows a custom centered popup.
    await showCenteredModal(
      title: lang.getText("settings"),
      messageType: MessageType.none,
      context: context,
      text: null,
      options: configureOptions(
        onTap: (int option) async => await saveToPrefs(option, apiLink.text),
        options: <String>[lang.getText("cancel"), lang.getText("save")],
        optionsAlignment: OptionsAlignment.auto,
        active: <String>[lang.getText("save")],
        context: context
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

  /// Builds image details.
  Column buildDetailsSection () => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      // Image to upload.
      Container(
        height: (MediaQuery.of(context).size.width < 322.0 ? 128.0 : 256.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          border: Border.all(
            color: Theme.of(context).dialogTheme.surfaceTintColor!,
            width: 1.0
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).cardTheme.shadowColor!,
              blurRadius: 8.0
            )
          ],
          image: (
            selectedImage == null ? null :
            DecorationImage(
              image: FileImage(selectedImage!),
              fit: BoxFit.cover
            )
          )
        )
      ),
      // Bottom margin.
      SizedBox(height: 8.0),
      // Image resolution.
      Label(
        align: TextAlign.center,
        text: resolution,
        style: TextStyle(
          color: Theme.of(context).dividerColor,
          fontFamily: AppFonts.sanFrancisco,
          fontSize: 14.0
        )
      ),
      // Bottom margin.
      SizedBox(height: 24.0),
      // Size row.
      buildDetailRow(lang.getText("weight"), size),
      // Bottom margin.
      SizedBox(height: 8.0),
      // Date row.
      buildDetailRow(lang.getText("date"), date),
      // Bottom margin.
      SizedBox(height: 8.0),
      // Time row.
      buildDetailRow(lang.getText("time"), time),
      // Bottom margin.
      SizedBox(height: 24.0),
      // Command controls.
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Pick another image.
          Button(
            textColor: Theme.of(context).dialogTheme.backgroundColor!,
            backgroundColor: Theme.of(context).primaryColorDark,
            onTap: (Object? _) async => await pickFromGallery(),
            radius: BorderRadius.all(Radius.circular(32.0)),
            text: lang.getText("anotherImage"),
            width: 108.0,
            leftIcon: Icon(
              Icons.image,
              color: Theme.of(context).dialogTheme.backgroundColor,
              size: 18.0
            )
          ),
          // Upload image to server.
          Button(
            textColor: Theme.of(context).dialogTheme.backgroundColor!,
            backgroundColor: Theme.of(context).primaryColorDark,
            radius: BorderRadius.all(Radius.circular(32.0)),
            onTap: (Object? _) async => uploadImage(),
            text: lang.getText("sendImage"),
            width: 108.0,
            leftIcon: Icon(
              Icons.send,
              color: Theme.of(context).dialogTheme.backgroundColor,
              size: 18.0
            )
          )
        ]
      )
    ]
  );

  /// Uploads current selected image to server.
  Future<void> uploadImage () async {
    // Whether selected image is undefined.
    if (selectedImage == null) return;
    // Gets configured api link.
    final String apiLink = await getConfiguredAPILink();
    // Whether no link found.
    if (apiLink.isEmpty) {
      // Whether context isn't mounted.
      if (!mounted) return;
      // Displays a toast.
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).cardTheme.surfaceTintColor,
        textColor: Theme.of(context).dialogTheme.surfaceTintColor,
        msg: lang.getText("noLinkFound"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0
      );
    // Otherwise.
    } else {
      // The selected image full path.
      final String path = selectedImage!.path;
      // The url to upload image to server.
      final Uri uri = Uri.parse(apiLink);
      // The file to upload.
      final MultipartFile file = await MultipartFile.fromPath(
        "file", path, filename: path.split('/').last
      );
      // Composes request for image upload.
      final MultipartRequest request = MultipartRequest("POST", uri)
        ..files.add(file);
      // Whether context is mounted.
      if (mounted) {
        // Displays a loader about a progressive task.
        showLoader(
          title: lang.getText("progressing"),
          context: context, infinite: true
        );
      }
      // Tries to upload this image to server.
      try {
        // Now, uploads selected image really.
        final StreamedResponse streamed = await request.send();
        // When server returns a response about upload.
        final Response response = await Response.fromStream(streamed);
        // Whether context isn't mounted.
        if (!mounted) return;
        // Closes opened loader.
        Navigator.pop(context);
        // Whether request doesn't succeeded.
        if (response.statusCode < 200 && response.statusCode > 299) {
          // An unknown error.
          throw Exception("Unable to upload this image.");
        // Otherwise.
        } else {
          // Shows a custom dialog box for successful upload operation.
          await showIosPopup(
            message: lang.getText("uploadSuccessMessage"),
            title: lang.getText("uploadSuccessTitle"),
            options: <String>[lang.getText("ok")],
            active: <String>[lang.getText("ok")],
            context: context
          );
        }
      // An error throw.
      } on Exception catch (error) {
        debugPrint("$error");
        // Whether context isn't mounted.
        if (!mounted) return;
        // Closes opened loader.
        Navigator.pop(context);
        // Shows a custom dialog box for failed upload operation.
        await showIosPopup(
          options: <String>[lang.getText("cancel"), lang.getText("retry")],
          active: <String>[lang.getText("retry")],
          title: lang.getText("uploadErrorTitle"),
          supportHTML: true,
          context: context,
          onTap: (int option) async {
            // Whether `retry` is pressed.
            if (option == 1) await uploadImage();
          },
          message: (
            lang.getText("uploadErrorMessage").replaceAll(
              "{details}", error.toString()
            )
          )
        );
      }
    }
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
    onPopInvokedWithResult: onBackButtonPressed,
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
                MediaQuery.of(context).size.width < 322.0 ? 16.0 : 22.0
              ),
              child: (
                isTransferView ? buildDetailsSection() : buildHomeSection()
              )
            )
          )
        ]
      )
    )
  );
}
