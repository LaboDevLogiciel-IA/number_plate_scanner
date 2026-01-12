/**
 * @fileoverview: Displays a graphical button with custom properties.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: button.dart
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

/// Custom dependencies.
import "../animations/animated_double.dart";
import "../utils/std.dart" show animatedTap;
import "../constants/fonts.dart";
import "./label.dart";

/// Defines a widget that is able to display a graphical button.
@immutable
class Button extends StatelessWidget {
  /// Attributes.
  final void Function(Object?)? onTap;
  final Color backgroundColor;
  final BorderRadius? radius;
  final BoxShadow? shadow;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final Color textColor;
  final bool isAnimated;
  final Border? border;
  final double? height;
  final double? width;
  final bool disabled;
  final String? text;
  final bool expand;
  final Object? id;

  /// Generates an outlined [Button] for different shape and action
  /// [context].
  ///
  /// Make sure you to give a valid [String] value if the [text] or
  /// [iconPath] field isn't empty. [Button]'s [width] and [height]
  /// must have a positive value.
  const Button ({
    required this.backgroundColor,
    this.isAnimated = false,
    required this.textColor,
    this.disabled = false,
    this.expand = false,
    this.rightIcon,
    this.leftIcon,
    this.height,
    this.shadow,
    this.border,
    this.radius,
    this.width,
    this.onTap,
    this.text,
    super.key,
    this.id
  });

  /// Builds the widget shape as a user interface with retrieved data.
  @override
  AnimatedDouble build (BuildContext context) {
    // The main button structure.
    final Container button = Container(
      height: height, width: width,
      // Apply a decoration.
      decoration: BoxDecoration(
        boxShadow: (shadow != null ? <BoxShadow>[shadow!] : null),
        color: backgroundColor,
        borderRadius: radius,
        border: border
      ),
      // Apply paddings.
      padding: EdgeInsets.only(
        bottom: 7.0, right: 9.0, left: 9.0, top: 7.0
      ),
      // Content structure.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Left icon.
          if (leftIcon != null) leftIcon!,
          // Left margin.
          if (leftIcon != null && text != null) SizedBox(width: 2.0),
          // Text.
          if (text != null) Flexible(
            child: Label(
              disabled: true,
              text: text,
              id: id,
              style: TextStyle(
                fontFamily: AppFonts.sanFrancisco,
                fontWeight: FontWeight.w600,
                color: textColor,
                fontSize: 16.0
              )
            )
          ),
          // Right margin.
          if (rightIcon != null && text != null) SizedBox(width: 2.0),
          // Right icon.
          if (rightIcon != null) rightIcon!
        ]
      )
    );
    // Builds generated button.
    return animatedTap(
      !expand ? button : Row(children: <Expanded>[Expanded(child: button)]),
      onCompleted: (onTap != null ? () => onTap!(id): null),
      borderRadius: BorderRadius.zero,
      isAnimated: isAnimated,
      disabled: disabled
    );
  }
}
