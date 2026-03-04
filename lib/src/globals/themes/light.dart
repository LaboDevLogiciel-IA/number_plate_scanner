/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @fileoverview: Defines application light theme data.
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-04
 * @file: light.dart
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "../models/theme.dart";

/// Light theme.
final Skin lightTheme = Skin(
  keywords: <String>["light", "clair"],
  name: "Light",
  theme: ThemeData(
    textTheme: TextTheme(labelSmall: TextStyle(color: Color(0xFF1F2937))),
    dividerTheme: DividerThemeData(color: Color(0xFFD9D9D9)),
    canvasColor: Color.fromRGBO(248, 92, 92, 1.0),
    cardColor: Color.fromRGBO(248, 224, 224, 1.0),
    scaffoldBackgroundColor: Color(0xFFE2E8F0),
    primaryColorLight: Color(0xFFB78AF7),
    primaryColorDark: Color(0xFF360083),
    disabledColor: Color(0xFFF0F0F0),
    primaryColor: Color(0xFF290064),
    cardTheme: CardThemeData(
      surfaceTintColor: Colors.black87,
      shadowColor: Colors.black54,
      color: Color(0xFFBFBFBF)
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.92),
      contentTextStyle: TextStyle(color: Colors.black26),
      surfaceTintColor: Colors.white,
      iconColor: Colors.grey
    )
  )
);
