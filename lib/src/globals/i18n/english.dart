/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into english.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-09
 * @file: english.dart
 * @version: 0.0.2
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
    "noPlateFound": "Sorry! No license plate found in this image.",
    "noPlatenumber": "No car or vehicle was found in this photo.",
    "quitMessage": "Are you sure you want to quit application?",
    "settingsSaveSuccess": "Settings saved successfully!",
    "copyright": "Copyright© 2026 – 2027 GASA Formation",
    "noChangeDetected": "No changes were made.",
    "tutorialTitle": "Scanning a license plate",
    "uploadSuccessTitle": "Sending successful",
    "appVersion": "version v0.3.0 • build 17",
    "resolution": "412 pixels x 2000 pixels",
    "retrieveErrorTitle": "Retrieval error",
    "uploadErrorTitle": "Sending failed",
    "loadErrorTitle": "Loading error",
    "selectImage": "Select an image",
    "anotherImage": "Another Image",
    "loadImage": "Uploading image",
    "startCamera": "Start camera",
    "sandboxMode": "Sandbox mode",
    "description": "Description",
    "timeValue": "23h:09min:44s",
    "progressing": "Uploading…",
    "dateValue": "25/04/2024",
    "weightValue": "1.95 MB",
    "progressPercent": "0%",
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
    "retrieveErrorMessage": (
      "Unable to retrieve and process responses from server correctly."
    ),
    "settingsMessage": (
      "Provide API link to contact for transfer of retrieved images."
    ),
    "loadErrorMessage": (
      "Please ensure the image isn't corrupted or damaged."
    ),
    "uploadErrorMessage": (
      "Check your network and ensure you have a "
      "stable internet connection, then try again."
    ),
    "tutorialMessage": (
      "Make sure that vehicle is visible in your photo "
      "along with its license plate and ensure that "
      "you have the clearest image possible."
    )
  }
);
