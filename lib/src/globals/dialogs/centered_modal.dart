/**
 * @fileoverview: The dialog box for displaying application message.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @file: centered_modal.dart
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-04
 * @version: 0.0.1
 */

/// Dart dependencies.
library;
import "dart:ui" show ImageFilter;

/// Flutter dependencies.
import "package:flutter/material.dart";

/// Plugins dependencies.
import "package:simple_animations/simple_animations.dart";

/// Custom dependencies.
import "../extensions/string.dart";
import "../constants/fonts.dart";
import "../widgets/button.dart";
import "../widgets/label.dart";

/// Enumerations.
enum MessageType {interrogation, information, success, error, none}
enum OptionsAlignment {horizontal, vertical, auto}

/// Returns the corresponding [alignment] direction according to the
/// selected [alignment] and available options.
OptionsAlignment parseAlignment (
  OptionsAlignment alignment, int optionCount
) {
  // Whether the alignment is auto.
  if (alignment == OptionsAlignment.auto) {
    // Whether there are less than or equal to two options.
    if (optionCount <= 2) {
      // Uses horizontal alignment.
      return OptionsAlignment.horizontal;
    // Otherwise.
    } else {
      // Uses vertical alignment.
      return OptionsAlignment.vertical;
    }
  // Otherwise.
  } else {
    // Don't affect the passed alignment.
    return alignment;
  }
}

/// Returns the message type associated icon.
Icon? getMessageTypeIcon (BuildContext context, MessageType type) {
  // Icon size.
  final double iconSize = (
    MediaQuery.of(context).size.width < 321.0 ? 60.0 : 70.0
  );
  // Checks the given message type.
  switch (type) {
    // For error message.
    case MessageType.success:
      return Icon(Icons.check_circle_outline, size: iconSize);
    // For error message.
    case MessageType.error:
      return Icon(Icons.error_outline, size: iconSize);
    // For quiz message.
    case MessageType.interrogation:
      return Icon(Icons.question_mark_outlined, size: iconSize);
    // For info message.
    case MessageType.information:
      return Icon(Icons.info_outline, size: iconSize);
    // Otherwise.
    default: return null;
  }
}

/// Converts the passed [Button]s into a valid [options] for a modal box.
Map<String, Object> parseButtons ({
  required OptionsAlignment alignment,
  required List<Button>? buttons,
  double? gap
}) {
  // The options list.
  final List<Widget> options = <Widget>[];
  // Whether some button(s) is/are given.
  if (buttons != null) {
    // Corrects the given alignment.
    alignment = parseAlignment(alignment, buttons.length);
    // The last index value.
    final int lastIndex = (buttons.length - 1);
    // Whether alignment is vertical.
    if (alignment == OptionsAlignment.vertical) {
      // Generating options.
      for (int x = 0; x < buttons.length; x++) {
        // Pushes the current button.
        options.add(Row(children: <Expanded>[Expanded(child: buttons[x])]));
        // Whether the current index is not equal to the last element index.
        if (x < lastIndex) options.add(SizedBox(height: gap));
      }
    // Whether alignment is horizontal.
    } else {
      // Generating options.
      for (int y = 0; y < buttons.length; y++) {
        // Pushes the current button.
        options.add(Expanded(child: buttons[y]));
        // Whether the current index is not equal to the last element index.
        if (y < lastIndex) options.add(SizedBox(width: gap));
      }
    }
  }
  // Returns the generated options.
  return <String, Object>{
    "count": options.length,
    "controls": (
      alignment == OptionsAlignment.vertical
      ? Column(children: options)
      : Row(children: options)
    )
  };
}

/// Generates a message box for application messages.
///
/// Make sure to give a valid [String] value for [message] or [title]
/// whether your [MessageBox] has a [title] and/or [message]. The [gap]
/// represents the distance of the blank spaces between [options] and
/// it's active if and only if there are more than one option available.
/// You can also apply a delay effect that can represent for e.g: The
/// time before close the modal. [onTimeout] is called if the current
/// time is great than the given [delay].
Future<void> showCenteredModal ({
  OptionsAlignment optionsAlignment = OptionsAlignment.auto,
  MessageType messageType = MessageType.information,
  required BuildContext context,
  void Function()? onTimeout,
  bool dismissible = false,
  bool supportHTML = false,
  required String? title,
  required String? text,
  List<Button>? options,
  double? optionsGap,
  Widget? content,
  int? delay
}) async {
  // The message icon path.
  final Icon? icon = getMessageTypeIcon(context, messageType);
  // Corrects the passed delay.
  delay = ((delay != null && delay > 0.0) ? delay : null);
  // Formats the given title.
  title = title?.getFilledString();
  // Formats the given text.
  text = text?.getFilledString();
  // The converted shape of the passed button(s).
  final Map<String, Object> data = parseButtons(
    gap: ((optionsGap != null && optionsGap > 0.0) ? optionsGap : null),
    alignment: optionsAlignment, buttons: options
  );
  // Creates a message box with the given data.
  return await showDialog(
    barrierDismissible: dismissible,
    context: context,
    builder: (BuildContext context) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        buttonPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))
        ),
        // Dialog global structure.
        content: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Whether icon is defined.
                if (icon != null) Padding(
                  padding: EdgeInsets.only(top: 15.0), child: icon
                ),
                // Whether title is defined.
                if (title != null) Padding(
                  padding: EdgeInsets.only(
                    right: 20.0, left: 20.0, top: 9.0
                  ),
                  child: Label(
                    align: TextAlign.center,
                    text: title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                      fontFamily: AppFonts.sanFrancisco,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )
                  )
                ),
                // Whether message content is defined.
                if (content == null && text != null) Padding(
                  padding: EdgeInsets.only(
                    bottom: ((data["count"] as int) > 0 ? 15.0 : 0.0),
                    right: 20.0, left: 20.0, top: 8.0
                  ),
                  child: Label(
                    supportHTML: supportHTML,
                    align: TextAlign.center,
                    text: text,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                      fontFamily: AppFonts.sanFrancisco,
                      fontSize: 16.0
                    )
                  )
                ),
                // Whether a custom widget content is required.
                if (content != null) content,
                // Whether options are defined.
                if ((data["count"] as int) > 0) Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (delay != null) PlayAnimationBuilder<double>(
                        duration: Duration(milliseconds: delay),
                        onCompleted: (
                          onTimeout != null ? () => onTimeout() : null
                        ),
                        tween: Tween(
                          end: MediaQuery.of(context).size.width,
                          begin: 0.0
                        ),
                        builder: (
                          BuildContext context, double value, Widget? _
                        ) => Container(
                          width: value, height: 1.5,
                          color: Theme.of(
                            context
                          ).dialogTheme.surfaceTintColor
                        )
                      ),
                      // Modal bottom controls.
                      (data["controls"] as Widget)
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    )
  );
}
