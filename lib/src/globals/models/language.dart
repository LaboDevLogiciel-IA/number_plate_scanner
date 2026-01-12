/**
 * @fileoverview: The class data model that represents app's texts.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: language.dart
 * @version: 0.0.1
 */

/// Dart dependencies.
library;
import "dart:convert" show jsonEncode, jsonDecode;

/// Custom dependencies.
import "../extensions/string.dart";
import "../extensions/list.dart";

/// Defines the class model that translates all application
/// labels texts into a [Language].
class Language {
  /// Attributes.
  Map<String, String>? _data;
  List<String>? _keywords;
  String? _flagCode;
  String? _name;

  /// Builds a custom [Language] class model object instance.
  ///
  /// Make sure to give a valid *[String]* value for _[name]_
  /// and _[flagCode]_ fields. Notice that your [flagCode]
  /// should contains a [String] of two characters only.
  /// Otherwise, an [Exception] will be thrown about that.
  Language ({
    required Map<String, String>? data,
    List<String>? keywords,
    required String? name,
    String? flagCode
  }) {
    // Updates keyword(s).
    setKeywords(keywords);
    // Updates flag's code.
    setFlagCode(flagCode);
    // Updates name.
    setName(name);
    // Updates data.
    setData(data);
  }

  /// Builds a [Language] object instance from a json data schema.
  ///
  /// Make sure to give a truthy [json]. A [FormatException] will
  /// throw whether the passed [String] doesn't respect a [json]
  /// architecture.
  factory Language.fromJson (String json) => Language.fromMap(
    // Converts the passed `json` into a readable map.
    jsonDecode(json)
  );

  /// Builds a [Language] object instance from a [map] data.
  /// Make sure you to give the corresponding data type for
  /// each [map] tag.
  factory Language.fromMap (Map<String, dynamic> map) => Language(
    keywords: (map["keywords"] is List<String> ? map["keywords"] : null),
    data: (map["data"] is Map<String, String> ? map["data"] : null),
    flagCode: (map["flagCode"] is String ? map["flagCode"] : null),
    name: (map["name"] is String ? map["name"] : null)
  );

  /// Clones an object instance of a [Language].
  /// Make sure to give a [Language] object reference.
  factory Language.clone (Language language) => Language(
    keywords: language._keywords,
    flagCode: language._flagCode,
    name: language._name,
    data: language._data
  );

  /// Sets supported keyword(s) by the [Language]. Make sure to give
  /// short tag(s) to allow searcher to identify your [Language]
  /// easily.
  void setKeywords (List<String>? keywords) => _keywords = keywords;

  /// Sets [Language]'s [name]. Make sure to give a valid [name] value.
  /// We'll consider that your [name] is `null` when you will pass an
  /// empty [String] or a [String] with blank spaces.
  void setName (String? name) => _name = name?.getFilledString();

  /// Returns [Language]'s data.
  Map<String, String> getData () => <String, String>{...?_data};

  /// Converts the current object instance into an array.
  List<Language> toList () => <Language> [this];

  /// Returns supported keywords.
  List<String>? getKeywords () => _keywords;

  /// Converts the current object instance of this class
  /// model into a json map.
  String toJson () => jsonEncode(toMap());

  /// Returns the better class display as string format.
  @override
  String toString () => _name.toString();

  /// Returns [Language]'s flag's code.
  String? getFlagCode () => _flagCode;

  /// Returns [Language]'s name.
  String? getName () => _name;

  /// Sets the current [Language]'s data. It's better to increase the
  /// number at the end of each value's key. Notice that the given
  /// [data] will be duplicated before assign them to the current [data].
  void setData (Map<String, String>? data) => _data = <String, String>{
    ...?data
  };

  /// Checks whether one or several [keys] are define inside
  /// [Language]'s data.
  ///
  /// Produces a boolean value that represents the match result.
  /// You must give a [String] or a [List] of [String].
  bool has (Object keys) => (
    _data != null ? _data!.keys.toList().hasAll(keys) : false
  );

  /// Converts the current object instance of this class model into a [map].
  Map<String, Object?> toMap () => <String, Object?>{
    "data": <String, String>{...?_data},
    "flagCode": _flagCode,
    "keywords": _keywords,
    "name": _name
  };

  /// Returns the associated text's worth of the given [key].
  ///
  /// Make sure to give a valid and defined [key]. Otherwise,
  /// `undefined` value is returned. Notice that `undefined`
  /// will also returned whether there aren't [Language]'s
  /// data.
  String getText (String key) {
    // The found text's value for the passed key.
    final List<String> worth = getTexts(<String>[key]);
    // Returns the final result.
    return (worth.isNotEmpty ? worth[0] : "undefined");
  }

  /// Returns all found text's value(s) according to its/those [keys]
  /// access.
  ///
  /// Make sure to give a valid and defined [keys]. Otherwise, an
  /// empty [List] will be returned.
  ///
  /// Notice that an empty [List] will also returned whether there
  /// aren't [Language]'s data.
  List<String> getTexts (List<String> keys) {
    // The found text(s).
    final List<String> texts = <String>[];
    // Whether language's data are defined.
    if (_data != null) {
      // Searching all given key(s).
      for (String key in keys) {
        // Whether the current key is defined.
        if (_data!.containsKey(key)) texts.add (_data![key]!);
      }
    }
    // Returns the final results.
    return texts;
  }

  /// Sets [Language]'s flag code. Notice that your [flagCode] should
  /// contains a [String] of two characters only. In others cases, an
  /// [Exception] will be thrown about that.
  void setFlagCode (String? flagCode) {
    // Whether the passed flag code is not null.
    if (flagCode != null) {
      // Corrects the passed iso code.
      flagCode = flagCode.toUpperCase().replaceAll(' ', '');
      // Whether characters count is different of two.
      if (flagCode.length != 2) {
        // Invalid iso code.
        throw Exception(
          "Flag code should contains two letters only. Not "
          "more and not less."
        );
      }
    }
    // Updates iso code.
    _flagCode = flagCode;
  }
}
