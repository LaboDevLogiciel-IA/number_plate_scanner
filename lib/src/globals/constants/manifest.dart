/**
 * @fileoverview: The global manifest's data across all app features.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-02-16
 * @file: manifest.dart
 * @version: 0.0.2
 */

/// Flutter dependencies.
library;
import "package:flutter/services.dart";

/// Custom dependencies.
import "../extensions/string.dart";
import "../models/language.dart";
import "../extensions/list.dart";
import "../models/theme.dart";
import "../themes/light.dart";
import "../i18n/english.dart";
import "../i18n/french.dart";
import "../themes/dark.dart";

/// Global enumerations.
enum AppLanguage {english, french, custom}
enum AppTheme {light, dark}

/// This class defines application manifest's data across constants values.
class AppManifest {
  /// Attributes.
  static const MethodChannel backend = MethodChannel("lp_scanner");
  static List<Language> languages = <Language>[english, french];
  static List<Skin> themes = <Skin>[lightTheme, darkTheme];
  static AppManifest instance = AppManifest._internal();
  static Language activeLanguage = french;
  static Skin activeTheme = lightTheme;

  /// Privatised constructor.
  AppManifest._internal();

  /// Returns whether current app's theme is light or not.
  static bool isLightTheme () {
    // The active theme name.
    final String themeName = activeTheme.toString().toLowerCase();
    // The statement result.
    return (themeName == "light" || themeName == "clair");
  }

  /// Searches a [Language] from an [id]. Make sure to give a valid
  /// _[String]_ value. We'll consider that your [id] is `null`
  /// when you will pass an empty [String] or a [String] with
  /// blank spaces.
  static Language? getLanguageBy (String id) {
    // Whether passed id is not `null`.
    if (id.getFilledString () != null) {
      // The corrected shape of passed id.
      id = id.replaceAll(' ', '').toLowerCase();
      // Searching language.
      for (int k = 0; k < languages.length; k++) {
        // Whether id matches with current language keyword(s).
        final bool isMatchKeywords = languages[k].getKeywords()!.has(id);
        // Whether id matches with current language's name.
        final bool isMatchName = (
          languages[k].getName()!.replaceAll(' ', '') == id
        );
        // Whether there are a match.
        if (isMatchKeywords || isMatchName) return languages[k];
      }
    }
    // Returns `null` for others cases.
    return null;
  }

  /// Searches a [Skin] from an [id]. Make sure to give a valid _[String]_
  /// value. We'll consider that your [id] is `null` when you will pass
  /// an empty [String] or a [String] with blank spaces.
  static Skin? getThemeBy (String id) {
    // Whether passed id is not `null`.
    if (id.getFilledString() != null) {
      // The corrected shape of passed id.
      id = id.replaceAll(' ', '').toLowerCase();
      // Searching theme.
      for (int k = 0; k < themes.length; k++) {
        // Whether id matches with current theme keyword(s).
        final bool isMatchKeywords = themes[k].getKeywords()!.has(id);
        // Whether id matches with current theme's name.
        final bool isMatchName = (
          themes[k].getName()!.replaceAll(' ', '') == id
        );
        // Whether there are a match.
        if (isMatchKeywords || isMatchName) return themes[k];
      }
    }
    // Returns `null` for others cases.
    return null;
  }
}
