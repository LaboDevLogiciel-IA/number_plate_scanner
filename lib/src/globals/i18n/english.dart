/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into english.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-23
 * @file: english.dart
 * @version: 0.0.3
 */

/// Custom dependencies.
library;
import "../models/language.dart";

/// English language.
final Language english = Language(
  name: "English",
  flagCode: "US",
  keywords: <String>[
    "united kingdom", "united states", "en_us", "us", "uk", "en"
  ],
  data: <String, String>{
    "uploadSuccessMessage": "Your image was successfully uploaded.",
    "quitMessage": "Are you sure you want to quit application?",
    "noLinkFound": "The api link is undefined in app settings.",
    "settingsSaveSuccess": "Settings saved successfully!",
    "copyright": "Copyright© 2026 – 2027 GASA Formation",
    "tutorialTitle": "Scanning a license plate",
    "appVersion": "version v0.4.0 • build 18",
    "uploadSuccessTitle": "Upload succeeded",
    "progressing": "Uploading in progress",
    "uploadErrorTitle": "Upload failed",
    "loadErrorTitle": "Loading failed",
    "selectImage": "Select an image",
    "anotherImage": "Another Image",
    "startCamera": "Start camera",
    "loadImage": "Load an image",
    "transfer": "Uploading",
    "settings": "Settings",
    "apiLink": "API Link",
    "sendImage": "Send",
    "cancel": "Cancel",
    "appName": "RAPI",
    "weight": "Size",
    "retry": "Retry",
    "home": "Home",
    "quit": "Quit",
    "time": "Time",
    "date": "Date",
    "save": "Save",
    "ok": "OK",
    "settingsMessage": (
      "Provide API link to contact for transfer of retrieved images."
    ),
    "loadErrorMessage": (
      "Please ensure the image isn't corrupted or damaged."
    ),
    "tutorialMessage": (
      "Make sure that vehicle is visible in your photo "
      "along with its license plate and ensure that "
      "you have the clearest image possible."
    ),
    "uploadErrorMessage": "<div>"
      "<span>Check your network and ensure you have a stable "
      "internet connection, then try again.</span><br/><br/>"
      "<details><summary>More details</summary><br/><span>"
      "{details}</span></details>"
    "</div>"
  }
);
