/**
 * @organization UATM GASA Formation - https://uatm-gasa.com
 * @author Obrymec - https://obrymec.vercel.app
 * @fileoverview Back-end native java module.
 * @file MainActivity.java
 * @created 2026-03-16
 * @updated 2026-03-16
 * @supported ANDROID
 * @version 0.0.1
 */

/// Package name.
package uatm.gasa.formation.license_plate_scanner;

/// Android dependencies.
import androidx.annotation.NonNull;

/// Flutter dependencies.
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;

/// Custom dependencies.
import uatm.gasa.formation.license_plate_scanner.utils.Preferences;

/**
 * Manages native back-end apis thank a channel.
 */
@SuppressWarnings("unused")
public class MainActivity extends FlutterActivity {
  /// Attributes.
  private static final String CHANNEL = "lp_scanner";

  /**
   * Loads last saved api link from local storage.
   */
  private String loadSettings () {
    // Loads data from preferences.
    return Preferences.getInstance().load("api_link", "", this.getApplicationContext());
  }

  /**
   * Saves given api link into local storage.
   * @param call The method parameters.
   */
  private void saveSettings (@NonNull MethodCall call) {
    // Gets new api link.
    final String newApiLink = call.argument("newApiLink");
    // Saves data to preferences.
    Preferences.getInstance().save("api_link", newApiLink, this.getApplicationContext());
  }

  /**
   * Called when a process call is carried out.
   * @param flutterEngine The Flutter engine.
   */
  public void configureFlutterEngine (@NonNull FlutterEngine flutterEngine) {
    // Gets messenger instance.
    final BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
    // Gets plugin registrant.
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    // Native java method call.
    new MethodChannel(messenger, CHANNEL).setMethodCallHandler((call, result) -> {
      // Checks called method from his name.
      switch (call.method) {
        // Loads api link from mobile preferences.
        case "loadApiLinkFromPreferences":
          // Sends method call result.
          result.success(this.loadSettings());
          // Don't go more.
          break;
        // Saves api link to mobile preferences.
        case "saveApiLinkToPreferences":
          // Saves new given api link to mobile preferences.
          this.saveSettings(call);
          // Don't go more.
          break;
        // Otherwise.
        default:
          // Nonexistent method call.
          result.notImplemented();
          // Don't go more.
          break;
      }
    });
  }
}
