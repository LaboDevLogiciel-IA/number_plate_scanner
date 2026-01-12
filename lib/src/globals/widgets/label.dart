/**
 * @fileoverview: The widget for displaying a graphical text label.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: label.dart
 * @version: 0.0.1
 */

/// Plugin dependencies.
library;
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

/// Flutter dependencies.
import "package:flutter/material.dart";

/// Defines a widget that is able to display a graphical text label.
@immutable
class Label extends StatelessWidget {
  /// Attributes.
  final void Function(Object?)? onTap;
  final TextStyle? style;
  final bool supportHTML;
  final TextAlign align;
  final bool disabled;
  final String? text;
  final Object? id;

  /// Builds a single graphical text label. Make sure you to give a valid
  /// [String] value if the [text] field isn't empty.
  const Label ({
    this.align = TextAlign.start,
    this.supportHTML = false,
    this.disabled = true,
    required this.text,
    this.style,
    this.onTap,
    super.key,
    this.id
  });

  /// Builds the widget shape as a user interface with retrieved data.
  @override
  Widget build (BuildContext _) => (
    text == null ? Container() :
    InkWell(
      // When the user tap over text.
      onTap: ((onTap != null && !disabled) ? () => onTap!(id) : null),
      // Feedback activation.
      enableFeedback: !disabled,
      // Text representation.
      child: (
        !supportHTML ?
        Text(text!, textAlign: align, style: style) :
        HtmlWidget(text!, textStyle: style)
      )
    )
  );
}
