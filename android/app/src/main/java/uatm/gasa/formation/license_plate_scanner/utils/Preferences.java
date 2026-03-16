/**
 * @fileoverview Provides commons methods for native android preferences.
 * @organization UATM GASA Formation - https://uatm-gasa.com
 * @author Obrymec - https://obrymec.vercel.app
 * @file Preferences.java
 * @created 2026-03-16
 * @updated 2026-03-16
 * @supported ANDROID
 * @version 0.0.1
 */

/// Package name.
package uatm.gasa.formation.license_plate_scanner.utils;

/// Android dependencies.
import android.content.SharedPreferences;
import android.content.Context;
import android.util.Log;

/**
 * Provides methods to manage native android preferences.
 */
@SuppressWarnings("unused")
public final class Preferences {
  /// Attributes.
  private static final String PREFS_NAME = "LP_SCANNER_PREFS";
  private static Preferences instance = null;

  /**
   * Blocks any object instantiation.
   */
  private Preferences () {}

  /**
   * Displays a log message for debugging treatments.
   * @param message The message to be printed on console.
   */
  @SuppressWarnings("all")
  private void debug (String message) {
    // Whether verbose mode is enabled.
    if (false) Log.d(PREFS_NAME, message);
  }

  /**
   * Returns a single instance of this class.
   * @return Preferences
   */
  @SuppressWarnings("all")
  public static Preferences getInstance () {
    // Whether there are no instance.
    if (instance == null) instance = new Preferences();
    // Sends that unique instance.
    return instance;
  }

  /**
   * Saves a key with its value into preferences.
   * @param key The data identifier key name.
   * @param value The stored data value.
   * @param ctx The current activity context.
   */
  public void save (String key, String value, Context ctx) {
    // Whether key or value aren't defined.
    if (value == null || key == null || ctx == null) this.debug("Unable to save {" + key + "}.");
    // Otherwise.
    else {
      // Gets shared preferences.
      final SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
      // Creating an editor object to write on file.
      final SharedPreferences.Editor editor = prefs.edit();
      // Storing key and its value as a data.
      editor.putString(key, value);
      // Commits changes.
      editor.apply();
    }
  }

  /**
   * Loads value associated to a key from prefs.
   * @param key The data identifier key name.
   * @param init The default value to send for unexpected cases.
   * @param ctx The current activity context.
   * @return String
   */
  public String load (String key, String init, Context ctx) {
    // Whether key and value are defined.
    if (ctx != null && key != null) {
      // Gets shared preferences.
      final SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
      // Fetches associated value.
      return prefs.getString(key, init);
    // Otherwise.
    } else {
      // Makes a debug log.
      this.debug("Unable to load {" + key + "}.");
      // No data found.
      return init;
    }
  }
}
