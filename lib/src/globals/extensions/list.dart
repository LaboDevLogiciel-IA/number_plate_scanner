/**
 * @fileoverview: Defines all useful extension methods for `List` class.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: list.dart
 * @version: 0.0.1
 */

/// Defines additional methods for dart [List] class.
extension ListExtension<T> on List<T> {
  /// Whether the passed element(s) is/are inside array.
  bool hasAll (dynamic elements, {bool casse = false}) {
    // Converts the passed element(s) into an array.
    elements = (elements is List ? elements : <Object?>[elements]);
    // Checking the given tags.
    for (int k = 0; k < elements.length; k++) {
      // Whether ever an element isn't defined on array.
      if (!has(elements.elementAt(k), casse: casse)) return false;
    }
    // All tag(s) are found on this input.
    return true;
  }

  /// Formats a list according to its content.
  dynamic format () {
    // Whether the list is empty.
    if (isEmpty) {
      // Returns null.
      return null;
    // Otherwise.
    } else {
      // Whether the list has one element.
      if (length == 1) {
        // Returns list first element.
        return this[0];
      // Otherwise.
      } else {
        // Returns the really list.
        return this;
      }
    }
  }

  /// Blends array's element(s) per pair.
  List<T> blend () {
    // The last index.
    final int lastIndex = (length - 1);
    // The final results.
    final List<T> results = <T>[];
    // Blending elements.
    for (int x = 0; x < length; x += 2) {
      // Whether the current position's index.
      if (x < lastIndex) {
        // Adds the next item before current item.
        results.addAll(<T>[this[(x + 1)], this[x]]);
      // Whether the current index is less than array's length.
      } else if (x < length) {
        // Adds current item.
        results.add(this[x]);
      // Otherwise.
      } else {
        // Gets out of loop.
        break;
      }
    }
    // Returns the final result(s).
    return results;
  }

  /// Checks whether an element is inside array.
  bool has (dynamic element, {bool casse = false}) {
    // Whether it's a list of string only.
    if (this is List<String> && element is String && !casse) {
      // Gets lower case form of the given element after
      // removed all blank spaces.
      element = element.toLowerCase().replaceAll(' ', '');
      // Searching the given active item.
      for (int i = 0; i < length; i++) {
        // The current item.
        final String item = (
          this[i].toString().replaceAll(' ', '').toLowerCase()
        );
        // Whether ever an item has an active item.
        if (
          item.contains(element) ||
          element.contains(item) ||
          item == element
        ) {return true;}
      }
    // Otherwise.
    } else {
      // Returns a basic search result.
      return contains(element);
    }
    // Returns a falsely value for others cases.
    return false;
  }
}
