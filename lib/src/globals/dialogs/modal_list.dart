/**
 * @fileoverview: Displays a modal that contains a list of widgets.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @supported: ANDROID & IOS
 * @file: modal_list.dart
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Custom dependencies.
import "./ios_popup.dart" show configureOptions, parseRadius, onClick;
import "./centered_modal.dart" show OptionsAlignment, parseButtons;
import "../utils/std.dart" show animatedTap, lang;
import "../animations/animated_double.dart";
import "../extensions/string.dart";
import "../constants/fonts.dart";
import "../widgets/label.dart";

/// Defines a [Widget] that is able to display a modal item that
/// contain an icon and a text.
@immutable
class ModalItem extends StatelessWidget {
  /// Attributes.
  final void Function(Object?)? onTap;
  final bool bottomDivider;
  final String? remoteID;
  final Color? textColor;
  final bool topDivider;
  final double radius;
  final bool disabled;
  final String? text;
  final Widget? icon;
  final Object? id;
  final bool error;

  /// Builds a graphical item for our modal box to be able to
  /// display a many [Widget]s that materialize the given infos.
  const ModalItem ({
    this.bottomDivider = true,
    this.topDivider = true,
    this.disabled = false,
    this.radius = 14.0,
    this.error = false,
    this.textColor,
    this.remoteID,
    this.onTap,
    super.key,
    this.text,
    this.icon,
    this.id
  });

  /// Builds the [Widget] shape as a user interface with retrieved data.
  @override
  AnimatedDouble build (BuildContext context) => animatedTap(
    Column(
      children: <Widget>[
        // Top divider.
        if (topDivider) Divider(
          color: Theme.of(context).dividerTheme.color, height: 0.0
        ),
        // Item content.
        Container(
          // Content structure.
          padding: EdgeInsets.only(bottom: 8.0, right: 8.0, top: 8.0),
          // Apply a decoration.
          decoration: BoxDecoration(
            color: Theme.of(context).dialogTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius)
            )
          ),
          child: Row(
            children: <Widget>[
              // Makes a little left margin.
              SizedBox(width: 10.0),
              // Item image.
              if (icon != null) Stack(
                children: <Widget>[
                  // Logo or icon.
                  icon!,
                  // Error zone.
                  if (error) Transform.translate(
                    offset: Offset(23.0, -5.0),
                    child: Icon(
                      Icons.error_outline,
                      color: Theme.of(context).canvasColor,
                      size: 10.0
                    )
                  )
                ]
              ),
              // Makes a little left margin.
              if (icon != null && text != null) SizedBox(width: 15.0),
              // Right data.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Item label.
                  if (text != null) Label(
                    supportHTML: true,
                    disabled: true,
                    text: text,
                    id: id,
                    style: TextStyle(
                      fontFamily: AppFonts.sanFrancisco,
                      fontSize: 16.0,
                      color: textColor ?? Theme.of(
                        context
                      ).textTheme.labelSmall!.color
                    )
                  ),
                  // Remote ID.
                  if (remoteID != null) Label(
                    supportHTML: true,
                    disabled: true,
                    text: remoteID,
                    id: id,
                    style: TextStyle(
                      color: Theme.of(context).dialogTheme.iconColor,
                      fontFamily: AppFonts.sanFrancisco,
                      fontSize: 14.0
                    )
                  )
                ]
              )
            ]
          )
        ),
        // Bottom divider.
        if (bottomDivider) Divider(
          color: Theme.of(context).dividerTheme.color, height: 0.0
        )
      ]
    ),
    onCompleted: (onTap != null ? () => onTap!(id) : null),
    borderRadius: BorderRadius.zero,
    disabled: disabled,
    isAnimated: true
  );
}

/// Builds a [List] of [ModalItem] with the possibility to search
/// element(s) through a tag.
@immutable
class ModalItemList extends StatefulWidget {
  /// Attributes.
  final List<ModalItem> items;
  final bool showSearchBar;
  final String? searchTag;
  final double? height;
  final int count;

  /// Initializes the [Key] and calls its parent constructor.
  ///
  /// The [Key] represents the unique id to identify this
  /// compositing [widgets].
  @override
  State<ModalItemList> createState () => _ModalItemListState();

  /// Creates a new object instance of its state.
  ///
  /// The state represents all different necessaries
  /// [widgets] to render graphically.
  const ModalItemList ({
    this.showSearchBar = false,
    required this.items,
    this.count = -1,
    this.searchTag,
    this.height,
    super.key
  });
}

/// Builds a [Widget] that contains a [List] of [ModalItem] that
/// may be change according to a [searchTag].
class _ModalItemListState extends State<ModalItemList> {
  /// Attributes.
  final TextEditingController _ctrl = TextEditingController();
  List<Widget> _foundItems = <Widget>[];
  String? tag;

  /// Formats the given [String] by removing all spaces inside it
  /// and make it to lower case.
  String? _format (String? string) => (
    string?.getFilledString()?.replaceAll(' ', '').toLowerCase()
  );

  /// Clears text input content whether the search bar is hidden.
  void _clearText () => setState(() {
    // Clears search input content.
    _ctrl.clear();
    // Clears tag.
    tag = '';
  });

  /// Called when this activity is mounted into the tree.
  ///
  /// Notice that, _[initState]_ method is called once only.
  /// If you mutate the state, this method won't call again.
  @override
  void initState () {
    // Calls the parent init state method.
    super.initState();
    // Initializes the search tag.
    tag = widget.searchTag;
  }

  /// Compares two [String] values. We'll return `true` if the second
  /// [String] is inside the first [String]. `false`, otherwise.
  bool _compareString ({
    required String? string1, required String? string2
  }) {
    // Formats the first string.
    string1 = _format(string1);
    // Checks matches.
    return (string1 != null && string1.contains(string2.toString()));
  }

  /// Searches and returns a [List] of [ModalItem] according to the given
  /// [searchTag].
  ///
  /// Whether no results is found, a _[Widget]_ with a message will be
  /// returned to notify user about no existing of the target item.
  void _search ({String? search, int count = -1}) {
    // The corrected shape of the tag.
    search = _format(tag);
    // Searching all matched items.
    final List<ModalItem> items = widget.items.where(
      (item) => _compareString(string1: item.text, string2: search)
    ).toList();
    // The corrected results count.
    count = (
      (count >= items.length || count < 0) ? items.length :
      (count > 0 ? (count + 1) : 0)
    );
    // Updates found items.
    _foundItems = (
      search == null ? widget.items :
      (
        count != 0 ? items.sublist(0, count) :
        <Widget>[
          // Top padding.
          SizedBox(height: 50.0),
          // Message container.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // No results found icon.
              Icon(
                Icons.not_interested,
                color: Theme.of(context).primaryColor,
                size: 16.0
              ),
              // A little gap.
              Padding(padding: EdgeInsets.only(right: 4.0)),
              // Message text.
              Label(
                text: lang.getText("noResultsFound"),
                align: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: AppFonts.sanFrancisco,
                  fontSize: 16.0
                )
              )
            ]
          ),
          // Bottom padding.
          SizedBox(height: 50.0)
        ]
      )
    );
  }

  /// Called when the state is ready and at all times where it mutates.
  ///
  /// When the view is ready, it generates its own [context] that
  /// represents the state's [BuildContext] bound to its activity.
  /// *[build]* method will call at every time if and only if
  /// *[setState]* method is called within a program.
  @override
  Column build (BuildContext context) {
    // Whether search bar is hidden.
    if (!widget.showSearchBar) _clearText();
    // Adjusts found items according to the initial values.
    _search(count: widget.count, search: tag);
    // Builds user interface.
    return Column(
      children: <Widget>[
        // Search bar.
        if (widget.showSearchBar) Column(
          children: <Widget>[
            // Top divider.
            Divider(
              color: Theme.of(context).dividerTheme.color, height: 0.0
            ),
            // Text input.
            SizedBox(
              height: 38.0,
              child: TextFormField(
                onChanged: (String value) => setState(() => tag = value),
                style: TextStyle(color: Theme.of(context).primaryColor),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.text,
                controller: _ctrl,
                autofocus: false,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).dialogTheme.contentTextStyle,
                  prefixIconColor: Theme.of(context).dialogTheme.iconColor,
                  suffixIconColor: Theme.of(context).dialogTheme.iconColor,
                  fillColor: Theme.of(context).dialogTheme.backgroundColor,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: lang.getText("search"),
                  border: InputBorder.none,
                  filled: true,
                  prefixIcon: Transform.translate(
                    offset: Offset(-6.0, 0.0),
                    child: Icon(Icons.search, size: 20.0)
                  ),
                  suffixIcon: (
                    _ctrl.text.isEmpty ? null :
                    Transform.translate(
                      offset: Offset(6.0, -2.5),
                      child: IconButton(
                        onPressed: () => _clearText(),
                        icon: Icon(Icons.clear)
                      )
                    )
                  )
                )
              )
            ),
            // Bottom divider.
            Divider(
              color: Theme.of(context).dividerTheme.color, height: 0.0
            )
          ]
        ),
        // Items list.
        SizedBox(
          height: widget.height,
          child: SingleChildScrollView(child: Column(children: _foundItems))
        )
      ]
    );
  }
}

/// Generates a modal list selection with the given data.
Future<void> showModalList ({
  OptionsAlignment optionsAlignment = OptionsAlignment.auto,
  void Function(int id)? onOptionTap,
  void Function(int id)? onItemTap,
  required BuildContext context,
  int searchResultCount = -1,
  bool showSearchBar = false,
  double? contentHeight,
  List<ModalItem>? rows,
  List<String>? options,
  List<String>? active,
  EdgeInsets? padding,
  double? optionsGap,
  String? searchTag,
  double? height,
  String? title
}) async {
  // The final result to be rendering.
  final List<ModalItem> items = <ModalItem>[];
  // Checks the given title.
  title = title?.getFilledString();
  // The converted shape of the passed button(s).
  final Map<String, Object> data = parseButtons(
    alignment: optionsAlignment,
    gap: optionsGap,
    buttons: configureOptions(
      optionsAlignment: optionsAlignment,
      onTap: onOptionTap,
      context: context,
      options: options,
      active: active
    )
  );
  // Whether the max number of button(s) is great than zero.
  final bool isEmpty = ((data["count"] as int) <= 0);
  // A list of rows is given.
  if (rows != null) {
    // The last row's position.
    final int lastIndex = (rows.length - 1);
    // Generating items.
    for (int k = 0; k < rows.length; k++) {
      // Adds the current item.
      items.add(
        ModalItem(
          onTap: onClick(context: context, onTap: onItemTap, index: k),
          textColor: rows[k].textColor,
          remoteID: rows[k].remoteID,
          error: rows[k].error,
          text: rows[k].text,
          icon: rows[k].icon,
          id: k,
          radius: parseRadius(
            boolean: isEmpty, value: lastIndex, index: k
          ).x
        )
      );
    }
  }
  // Builds a popup dialog for the final rendering.
  return await showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Makes a little top margin.
            if (title != null) SizedBox(height: (
              MediaQuery.of(context).size.width < 321.0 ? 5.0 : 3.6
            )),
            // Modal title list.
            if (title != null) Label(
              align: TextAlign.center,
              text: title,
              style: TextStyle(
                color: Theme.of(context).textTheme.labelSmall!.color,
                fontFamily: AppFonts.sanFrancisco,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              )
            ),
            // Makes a little bottom margin.
            if (title != null) SizedBox(height: 7.0),
            // Dialog content.
            if (items.isNotEmpty) SizedBox(
              height: height,
              child: ModalItemList(
                showSearchBar: showSearchBar,
                count: searchResultCount,
                height: contentHeight,
                searchTag: searchTag,
                items: items
              )
            ),
            // Modal bottom controls.
            if (!isEmpty) (data["controls"] as Widget)
          ]
        )
      )
    )
  );
}
