/**
 * @fileoverview: The class data model that represents an app's theme.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: theme.dart
 * @version: 0.0.1
 */

/// Dart dependencies.
library;
import "dart:convert" show jsonEncode, jsonDecode;

/// Flutter dependencies.
import "package:flutter/material.dart" show ThemeData;

/// Custom dependencies.
import "../extensions/string.dart";

/// Defines the class model that represents an application UI [Skin].
class Skin {
  /// Attributes.
  List<String>? _keywords;
  String? _iconPath;
  ThemeData? _theme;
  String? _name;

  /// Builds a [Skin] class model object instance.
  ///
  /// Make sure to give a valid [String] value for
  /// _[iconPath]_ and _[name]_ fields.
  Skin ({
    required ThemeData? theme,
    List<String>? keywords,
    required String? name,
    String? iconPath
  }) {
    // Updates icon's path.
    setIconPath(iconPath);
    // Updates keyword(s).
    setKeywords(keywords);
    // Updates theme.
    setTheme(theme);
    // Updates name.
    setName(name);
  }

  /// Builds a [Skin] object instance from a [json] data schema.
  ///
  /// Make sure to give a truthy _[json]_ data. Whether the
  /// passed *[String]* doesn't respect a [json] schema, a
  /// [FormatException] will be thrown.
  factory Skin.fromJson (String json) => Skin.fromMap(jsonDecode(json));

  /// Builds a [Skin] object instance from a [map] data.
  /// Make sure you to give the corresponding data type
  /// for each [map] tag.
  factory Skin.fromMap (Map<String, dynamic> map) => Skin(
    keywords: (map["keywords"] is List<String> ? map["keywords"] : null),
    iconPath: (map["iconPath"] is String ? map["iconPath"] : null),
    theme: (map["theme"] is ThemeData ? map["theme"] : null),
    name: (map["name"] is String ? map["name"] : null)
  );

  /// Clones an object instance of a [Skin]. Make sure to give a
  /// [Skin] object reference.
  factory Skin.clone (Skin theme) => Skin(
    keywords: theme._keywords,
    iconPath: theme._iconPath,
    theme: theme._theme,
    name: theme._name
  );

  /// Sets icon's path. Make sure to give a valid [path] value.
  ///
  /// We'll consider that your [path] is `null` when you will
  /// pass an empty [String] or a [String] with blank spaces.
  void setIconPath (String? path) => _iconPath = path?.getFilledString();

  /// Sets supported keyword(s) by the [Theme]. Make sure to give
  /// short tag(s) to allow searcher to identify your [Theme] easily.
  void setKeywords (List<String>? keywords) => _keywords = keywords;

  /// Sets [Theme]'s [name]. Make sure to give a valid [name] value.
  /// We'll consider that your [name] is `null` when you will pass
  /// an empty [String] or a [String] with blank spaces.
  void setName (String? name) => _name = name?.getFilledString();

  /// Sets [Theme]'s data. The [Theme] is the global [Skin]
  /// of all UI and views within app.
  void setTheme (ThemeData? theme) => _theme = theme;

  /// Returns supported keywords.
  List<String>? getKeywords () => _keywords;

  /// Converts the current object instance of this class
  /// model into a json [map].
  String toJson () => jsonEncode(toMap());

  /// Returns the better class display as string format.
  @override
  String toString () => _name.toString();

  /// Converts the current object instance into an array.
  List<Skin> toList () => <Skin>[this];

  /// Returns icon's path.
  String? getIconPath () => _iconPath;

  /// Returns [Theme]'s data.
  ThemeData? getTheme () => _theme;

  /// Returns [Theme]'s name.
  String? getName () => _name;

  /// Converts the current object instance of this class
  /// model into a [map].
  Map<String, Object?> toMap () => <String, Object?>{
    "iconPath": _iconPath,
    "keywords": _keywords,
    "theme": _theme,
    "name": _name
  };
}
