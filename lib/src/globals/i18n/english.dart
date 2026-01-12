/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into english.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: english.dart
 * @version: 0.0.1
 */

/// Custom dependencies.
library;
import "../models/language.dart";

/// English language.
final Language english = Language(
  name: "English",
  flagCode: "US",
  keywords: <String>[
    "united kingdom",
    "united states",
    "en_us",
    "us",
    "uk",
    "en"
  ],
  data: <String, String>{
    "bluetoothUnexpectedDisconnectionTitle": "Connection broken",
    "quitMsg": "Are you sure you want to exit the app now ?",
    "establishBluetooth": "Connect to Wheelchair bluetooth",
    "bluetoothConnectionFailedTitle": "Connection failed",
    "breakBluetooth": "Break Wheelchair connection",
    "ongoingTreatment": "Processing, please wait",
    "devicesList": "Bluetooth devices list",
    "noResultsFound": "No result(s) found",
    "gasaFormation": "UATM GASA-Formation",
    "appInfo": "version 0.0.4 - build 04",
    "scanFailedTitle": "Scanning error",
    "bluetooth": "Wheelchair Bluetooth",
    "scanProcessing": "Scan processing",
    "unknownDevice": "Unknown device",
    "disconnected": "Disconnected",
    "developedBy": "Developed by",
    "queryTitle": "Interrogation",
    "appName": "GASA Wheelchair",
    "reconnect": "Reconnect",
    "connected": "Connected",
    "validate": "Validate",
    "refresh": "Refresh",
    "search": "Search",
    "status": "Status",
    "cancel": "Cancel",
    "retry": "Retry",
    "speed": "SPEED",
    "quit": "Quit",
    "back": "Back",
    "jack": "JACK",
    "yes": "YES",
    "no": "NO",
    "bluetoothDisconnectErrMsg": (
      "Unable to achieve the disconnection causing by a unknown error."
    ),
    "bluetoothDisconnectReqMsg": """<div style = "text-align:center;">
      Do you really want to disconnect from device <b>{name}</b>
      with address <b>{address}</b> ?
    </div>""",
    "connectionMsg": """<div style = "text-align:center;">
      Are you sure you want to connect to device <b>{name}</b>
      with address <b>{address}</b> ?
    </div>""",
    "connectionEstablished": (
      "✅ Bluetooth connection successful established to <b><i>{name}</i>"
      "</b>: <b><i>{address}</i></b>!"
    ),
    "scanFailedMsg": """<div style = "text-align:center;">
      An error occurred while scanning for devices with Bluetooth 
      enabled and in close proximity. <i><b>Error code: {error}</b></i>
    </div>""",
    "bluetoothOffMsg": (
      "Your phone's Bluetooth is not enabled. "
      "Please enable it and try again."
    ),
    "bluetoothConnectionMsg": (
      "Check the Bluetooth status of your mobile phone and "
      "your device and make sure you are within 10 meters "
      "of your device."
    ),
    "screenHelpMsg": (
      "ℹ️ Connect to the wheelchair Bluetooth by pressing "
      "<b>Connect to Wheelchair Bluetooth</b> button at "
      "the bottom app."
    )
  }
);
