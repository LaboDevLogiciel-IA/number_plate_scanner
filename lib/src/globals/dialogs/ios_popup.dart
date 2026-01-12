/**
 * @fileoverview: The widget for displaying info message within a dialog.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @file: ios_popup.dart
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "../widgets/button.dart";
import "./centered_modal.dart"
  show parseAlignment, showCenteredModal,
  OptionsAlignment, MessageType;

/// The borders radius parser according to
/// [Button]'s control id for modal box.
Radius parseRadius ({
  bool boolean = true, required int index, required int value
}) => Radius.circular((index == value && boolean) ? 14.0 : 0.0);

/// Listens and calls [onTap] if any [Button] has been pressed.
void Function(Object?)? onClick ({
  required void Function(int id)? onTap,
  required BuildContext context,
  required int index
}) => (
  onTap == null ? (Object? _) => Navigator.of(context).pop() :
  (Object? _) {
    // Closes message box.
    Navigator.of(context).pop();
    // Calls given callback.
    onTap(index);
  }
);

/// Returns a message box for common infos configurations.
///
/// Make sure to give a valid [String] value for _[message]_ or _[title]_
/// whether your __[MessageBox]__ has a [title] and/or [message]. When
/// [onTap] method callback is called, the trigger's option name will
/// be passed as an argument. For more infos, see [showCenteredModal].
Future<void> showIosPopup ({
  OptionsAlignment optionsAlignment = OptionsAlignment.auto,
  MessageType type = MessageType.none,
  required BuildContext context,
  void Function(int id)? onTap,
  void Function()? onTimeout,
  bool supportHTML = false,
  required String message,
  List<String>? options,
  List<String>? active,
  String? title,
  int? delay
}) async => await showCenteredModal(
  optionsAlignment: optionsAlignment,
  supportHTML: supportHTML,
  messageType: type,
  context: context,
  text: message,
  title: title,
  delay: delay,
  options: configureOptions(
    optionsAlignment: optionsAlignment,
    options: options,
    context: context,
    active: active,
    onTap: onTap
  ),
  onTimeout: (
    onTimeout == null ? null :
    () {
      // Closes message box.
      Navigator.of(context).pop();
      // Calls the given callback.
      onTimeout();
    }
  )
);

/// Builds modal bottom controls like ios popup [Button]s.
List<Button> configureOptions ({
  required OptionsAlignment optionsAlignment,
  required void Function(int id)? onTap,
  required List<String>? options,
  required BuildContext context,
  List<String>? active
}) {
  // The options as a list of buttons.
  final List<Button> buttons = <Button>[];
  // Whether some options are specified.
  if (options != null) {
    // Corrects the given alignment.
    optionsAlignment = parseAlignment(optionsAlignment, options.length);
    // The last index value.
    final int lastIndex = (options.length - 1);
    // The option button data model.
    final Button option = Button(
      textColor: Theme.of(context).textTheme.labelSmall!.color!,
      backgroundColor: Colors.transparent,
      isAnimated: true,
      expand: true,
      height: 40.0,
      border: Border(
        top: BorderSide(color: Theme.of(context).cardTheme.color!)
      )
    );
    // Whether alignment is vertical.
    if (optionsAlignment == OptionsAlignment.vertical) {
      // Generating options according to the given data.
      for (int i = 0; i < options.length; i++) {
        // Builds the current option.
        buttons.add(
          Button(
            onTap: onClick(context: context, onTap: onTap, index: i),
            backgroundColor: option.backgroundColor,
            isAnimated: option.isAnimated,
            expand: option.expand,
            height: option.height,
            border: option.border,
            text: options[i],
            id: i,
            radius: BorderRadius.only(
              bottomRight: parseRadius(value: lastIndex, index: i),
              bottomLeft: parseRadius(value: lastIndex, index: i)
            ),
            textColor: (
              (active != null && active.contains(options[i])) ?
              Theme.of(context).primaryColor : option.textColor
            )
          )
        );
      }
    // Whether alignment is horizontal.
    } else {
      // Generating options according to the given data.
      for (int j = 0; j < options.length; j++) {
        // Builds the current option.
        buttons.add(
          Button(
            onTap: onClick(context: context, onTap: onTap, index: j),
            backgroundColor: option.backgroundColor,
            isAnimated: option.isAnimated,
            expand: option.expand,
            height: option.height,
            text: options[j],
            id: j,
            border: Border(
              right: (j < lastIndex ? option.border!.top : BorderSide.none),
              top: option.border!.top
            ),
            radius: BorderRadius.only(
              bottomRight: parseRadius(value: lastIndex, index: j),
              bottomLeft: parseRadius(value: 0, index: j)
            ),
            textColor: (
              (active != null && active.contains(options[j])) ?
              Theme.of(context).primaryColor : option.textColor
            )
          )
        );
      }
    }
  }
  // Returns the final results.
  return buttons;
}
