/**
 * @fileoverview: Defines all useful extension methods for `String` class.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: string.dart
 * @version: 0.0.1
 */

/// Extensions methods for dart [String] class.
extension StringExtension on String {
  /// Returns a nullable string whether his value is empty.
  String? getFilledString () {
    // Removes left and right spaces.
    final String formattedString = trimLeft().trimRight();
    // Returns the final value.
    return (formattedString.isNotEmpty ? formattedString : null);
  }

  /// Transforms each first letter of words into a string to upper case.
  String capitalize () => replaceAll(RegExp(" +"), ' ').split (' ')
    .map ((String str) => (
      str.isNotEmpty ? "${str[0].toUpperCase()}"
      "${str.substring(1).toLowerCase()}" : ''
    )
  ).join(' ');

  /// Replaces all found keywords into string to their corresponding value.
  String format (Map<String, Object?> configs) {
    // Whether some tags have been found.
    if (contains('{') && contains('}')) {
      // Gets configuration keys list.
      final List<String> keys = configs.keys.toList();
      // Contains the final result.
      String formatted = this;
      // Parsing the given string.
      for (int n = 0; n < keys.length; n++) {
        // Replaces the current tag into his value from the
        // given configurations.
        formatted = formatted.replaceAll(
          "{${keys[n].trim()}}", configs[keys[n]].toString()
        );
      }
      // Returns the final result.
      return formatted;
    }
    // Returns string with no modifications.
    return this;
  }

  /// Cuts a string with a limit value.
  String cut (int limit, {int gap = 3}) {
    // Whether limit is inside of the text's length.
    if (limit > 0 && limit < (length - gap)) {
      // Removes the left and right spaces.
      final String string = trimLeft().trimLeft();
      // The final result.
      String leftTextPart = '';
      // Getting the first part of the text.
      for (int j = 0; j < limit; j++) {
        // Adds each text character.
        leftTextPart = "$leftTextPart${string[j]}";
      }
      // Returns the split text.
      return leftTextPart.padRight((leftTextPart.length + gap), '.');
    // Whether no limit is provided.
    } else if (limit == 0) {
      // Returns three points.
      return "...";
    }
    // Returns string with no modifications.
    return this;
  }

  /// Writes a [String] with the given interval.
  Future<void> write ({
    void Function(String)? onFinished,
    void Function(String)? onWrite,
    int interval = 200
  }) async {
    // Removes left and right spaces.
    final String text = trimLeft().trimRight();
    // Whether text is defined.
    if (text.isNotEmpty) {
      // The current written character(s).
      String written = '';
      // Writing process.
      for (int n = 0; n < text.length; n++) {
        // Waits for the given interval before put the next character.
        await Future.delayed(Duration(milliseconds: interval), () {
          // Writes the current text character.
          written = "$written${text[n]}";
          // Whether `onWrite` is listening.
          if (onWrite != null) onWrite(written);
        });
      }
      // Waits for writing finished.
      await Future.delayed(
        Duration(milliseconds: (text.length * interval)), () {
          // Whether `onFinished` is listening.
          if (onFinished != null) onFinished(text);
        }
      );
    }
  }

  /// Backspaces a [String] with the given interval.
  Future<void> backspace ({
    void Function(String)? onBackspace,
    void Function(String)? onFinished,
    int interval = 200
  }) async {
    // Removes left and right spaces.
    final String text = trimLeft().trimRight();
    // Whether text is defined.
    if (text.isNotEmpty) {
      // The current backspaced text.
      String backspaced = text;
      // Backspacing process.
      for (int t = (text.length - 1); t >= 0; t--) {
        // Waits for the given interval before remove the next character.
        await Future.delayed(Duration(milliseconds: interval), () {
          // Removes the current text character.
          backspaced = (
            t > 0 ? backspaced.substring(0, (backspaced.length - 1)) : ''
          );
          // Whether `onBackspace` is listening.
          if (onBackspace != null) onBackspace(backspaced);
        });
      }
      // Waits for writing finished.
      await Future.delayed(
        Duration(milliseconds: (text.length * interval)), () {
          // Whether `onFinished` is listening.
          if (onFinished != null) onFinished('');
        }
      );
    }
  }

  /// Returns the formatted shape of the given money.
  ///
  /// Note that your [String] must be in full number
  /// and respect basic XOF money syntax.
  String toXOFMoney () {
    // Removes all blank spaces.
    final String money = replaceAll(' ', '');
    // Whether the passed money value and his length.
    if (money.isNotEmpty && money.length > 3) {
      // The formatted money data.
      final List<dynamic> formattedMoney = <dynamic>['', 0];
      // Formatting money.
      for (int t = (money.length - 1); t >= 0; t--) {
        // Tries this line of code.
        try {
          // Increases the current characters count.
          formattedMoney[1]++;
          // Adds the current character to the formatted money.
          formattedMoney[0] = (
            "${int.parse(money[t]).toString()}${formattedMoney[0]}"
          );
          // Whether the given value has more than three characters digits.
          if (formattedMoney[1] >= 3) {
            // Adds a space to the current amount formatting.
            formattedMoney[0] = "${(t > 0 ? ' ' : '')}${formattedMoney[0]}";
            // Resets the character count.
            formattedMoney[1] = 0;
          }
        // An error occurred.
        } on Exception catch (_, _) {
          // Invalid character format.
          throw Exception("Cannot convert {${money[t]}} into an integer.");
        }
      }
      // Returns the final result.
      return formattedMoney[0];
    }
    // Returns string with no modifications.
    return this;
  }
}
