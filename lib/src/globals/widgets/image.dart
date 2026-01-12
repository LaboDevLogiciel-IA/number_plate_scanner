/**
 * @fileoverview: The widget for displaying icons, logos, svg and images.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: image.dart
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Plugin dependencies.
import "package:flutter_svg/flutter_svg.dart";

/// Custom dependencies.
import "../utils/std.dart" show animatedTap;

/// Defines a [Widget] that can display an image/icon/logo from its access
/// file.
///
/// This widget uses [flutter] svg _[package]_ to able to show svg files.
/// You can also display an image/logo/icon according to its [package].
@immutable
class ImageIconLogoDisplayer extends StatelessWidget {
  /// Attributes.
  final void Function(Object?)? onTap;
  final String? package;
  final double? height;
  final bool disabled;
  final double? width;
  final double scale;
  final String? path;
  final Object? id;

  /// Builds icon/logo/image displayer widget. Make sure you to give a
  /// valid [String] value if the [package] or [path] field isn't empty.
  /// [ImageIconLogoDisplayer] [width], [height] and [scale] must have
  /// a positive value.
  const ImageIconLogoDisplayer ({
    this.disabled = false,
    this.height = 0.0,
    this.width = 0.0,
    this.scale = 0.5,
    this.package,
    this.onTap,
    this.path,
    super.key,
    this.id
  });

  /// Builds the [Widget] shape as a user interface with its retrieved data.
  @override
  Widget build (BuildContext context) {
    // Whether the given image format matches one of those constraints.
    if (
      path!.endsWith(".jpeg") ||
      path!.endsWith(".png") ||
      path!.endsWith(".jpg") ||
      path!.endsWith(".ico")
    ) {
      // Returns a matrix image.
      return animatedTap(
        Container(
          height: height, width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: scale, image: AssetImage(path!, package: package)
            )
          )
        ),
        onCompleted: (onTap != null ? () => onTap!(id) : null),
        borderRadius: BorderRadius.zero,
        disabled: disabled,
        isAnimated: false,
        end: 0.08
      );
    // Whether it's a vector image.
    } else if (path!.endsWith(".svg")) {
      // Returns a SVG image vector.
      return animatedTap(
        SizedBox(
          height: height, width: width,
          child: SvgPicture.asset(path!, package: package)
        ),
        onCompleted: (onTap != null ? () => onTap!(id) : null),
        borderRadius: BorderRadius.zero,
        disabled: disabled,
        isAnimated: false,
        end: 0.16
      );
    }
    // Returns an empty container for others invalid cases.
    return Container();
  }
}
