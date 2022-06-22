import 'dart:html';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// A handle to the location of a widget in the widget tree.
///
abstract class BuildContext {
  /// Associated widget's key.
  ///
  /// Accessing it is not valid on root context(see: [BuildContext.isRoot]).
  ///
  Key? get key;

  /// The configuration for this render element.
  ///
  /// Accessing it is not valid on root context(see: [BuildContext.isRoot]).
  ///
  Widget get widget;

  /// Widget's concrete type.
  ///
  String get widgetType;

  /// Widget's runtime type.
  ///
  String get widgetRuntimeType;

  /// Whether current context is root.
  ///
  bool get isRoot;

  /// App's target id.
  ///
  String get appTargetId;

  /// Returns dom node that's associated with the current context.
  ///
  /// If widget has no corresponding dom node then this method will return the
  /// closest dom node from descendants. If there are no dom nodes in
  /// descendants then this method will return closest dom node from ancestors.
  ///
  Element findClosestDomNode();

  /// Retruns the nearest dom node in ancestors.
  ///
  Element? findClosestDomNodeInAncestors();

  /// Retruns the nearest dom node in descendants.
  ///
  Element? findClosestDomNodeInDescendants();

  /// Returns the nearest ancestor widget of the given type `T`, which must be
  /// the type of a concrete [Widget] subclass.
  ///
  T? findAncestorWidgetOfExactType<T extends Widget>();

  /// Returns the [State] object of the nearest ancestor [StatefulWidget] widget
  /// that is an instance of the given type `T`.
  ///
  T? findAncestorStateOfType<T extends State>();

  /// Returns the [State] object of the furthest ancestor [StatefulWidget]
  /// widget that is an instance of the given type `T`.
  ///
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>();

  /// Returns the nearest ancestor render element of the given type `T`, which
  /// must be the type of a concrete [RenderElement] subclass.
  ///
  T? findAncestorRenderElementOfExactType<T extends RenderElement>();

  /// Obtains the nearest widget of the given type `T`, which must be the type
  /// of a concrete [InheritedWidget] subclass, and registers this build context
  /// with that widget such that when that widget changes (or a new widget of
  /// that type is introduced, or the widget goes away), this build context is
  /// rebuilt so that it can obtain new values from that widget.
  ///
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>();

  /// Walks the ancestor chain, starting with the parent of this build context's
  /// widget, invoking the argument for each ancestor. The callback is given a
  /// reference to the ancestor widget's corresponding [Element] object. The
  /// walk stops when it reaches the root widget or when the callback returns
  /// false.
  ///
  void visitAncestorElements(RenderElementVisitor visitor);

  /// Walks the children of this render element. The callback is given a
  /// reference to the child widget's corresponding [Element] object. The
  /// walk stops when it reaches the end of child or when the callback returns
  /// false.
  ///
  void visitChildElements(RenderElementVisitor visitor);

  /// Traverse the ancestor elements.
  ///
  void traverseAncestorElements(RenderElementCallback callback);

  /// Traverse the child elements of this render element.
  ///
  void traverseChildElements(RenderElementCallback callback);
}
