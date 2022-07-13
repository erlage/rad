// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/tasks/stimulate_listener_task.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// A widget for adding native event listeners.
///
class RawEventDetector extends StatefulWidget {
  /// Events to listen in bubble phase.
  ///
  final Map<String, NativeEventCallback>? events;

  /// Events to listen in capture phase.
  ///
  final Map<String, NativeEventCallback>? eventsCapture;

  /// Child widget.
  ///
  final Widget child;

  const RawEventDetector({
    Key? key,
    required this.child,
    this.events,
    this.eventsCapture,
  }) : super(key: key);

  @override
  _RawEventDetectorState createState() => _RawEventDetectorState();
}

class _RawEventDetectorState extends State<RawEventDetector> {
  Element? _domNode;

  @override
  void initState() {
    _addPostRenderTask(() {
      _updateEventListeners(newWidget: widget, oldWidget: null);
    });
  }

  @override
  void didUpdateWidget(RawEventDetector oldWidget) {
    _addPostRenderTask(() {
      _updateEventListeners(newWidget: widget, oldWidget: oldWidget);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    var domNode = _domNode;

    if (null != domNode) {
      _setupEventListeners(
        domNode: domNode,
        newWidget: null,
        oldWidget: widget,
      );
    }
  }

  /// Add a task to run after current render task is over.
  ///
  /// [RawEventDetector] don't have a dom node of it's own, instead it
  /// adds event listeners on its child tree but child tree is always
  /// built/updated after current widget finishes rendering(build method).
  ///
  /// This method allows running callbacks in a separate task(which scheduler
  /// will run after current task is over) so that event detector can operate on
  /// correct/updated dom nodes in descendants.
  ///
  void _addPostRenderTask(VoidCallback taskToRun) {
    var renderElement = context as StatefulRenderElement;

    renderElement.frameworkServices.scheduler.addTask(
      StimulateListenerTask(afterTaskCallback: taskToRun),
    );
  }

  void _handleEvent({
    required Event event,
    required bool inCapturePhase,
  }) {
    NativeEventCallback? listener;

    if (inCapturePhase) {
      listener = widget.eventsCapture?[event.type];
    } else {
      listener = widget.events?[event.type];
    }

    if (null != listener) {
      listener(event);
    }
  }

  /// Handler for events in capture phase.
  ///
  void _handleBubbleEvent(Event event) {
    _handleEvent(event: event, inCapturePhase: false);
  }

  /// Handler for events in bubble phase.
  ///
  void _handleCaptureEvent(Event event) {
    _handleEvent(event: event, inCapturePhase: true);
  }

  void _updateEventListeners({
    required RawEventDetector? newWidget,
    required RawEventDetector? oldWidget,
  }) {
    var oldDomNode = _domNode;
    var newDomNode = context.findClosestDomNode();

    // If oldDomNode is null(initial build) or oldDomNode == newDomNode, then
    //
    // 1. Setup/Update event listeners
    // 2. Update dom node reference if oldDomNode is null
    //
    if (null == oldDomNode || oldDomNode == newDomNode) {
      _setupEventListeners(
        domNode: newDomNode,
        newWidget: newWidget,
        oldWidget: oldWidget,
      );

      _domNode ??= newDomNode;

      return;
    }

    // Else it means oldDomNode != newDomNode, and we've to
    //
    // 1. Remove all event listeners from oldDomNode
    // 2. Add all event listeners to newDomNode
    // 3. Update dom node reference
    //

    _setupEventListeners(
      domNode: oldDomNode,
      newWidget: null,
      oldWidget: oldWidget,
    );

    _setupEventListeners(
      domNode: newDomNode,
      newWidget: newWidget,
      oldWidget: null,
    );

    _domNode = newDomNode;
  }

  void _setupEventListeners({
    required Element domNode,
    required RawEventDetector? newWidget,
    required RawEventDetector? oldWidget,
  }) {
    var emptyMap = ccImmutableEmptyMapOfRawEventListeners;

    var newEventListenersInBubblePhase = newWidget?.events ?? emptyMap;
    var newEventListenersInCapturePhase = newWidget?.eventsCapture ?? emptyMap;

    var oldEventListenersInBubblePhase = oldWidget?.events ?? emptyMap;
    var oldEventListenersInCapturePhase = oldWidget?.eventsCapture ?? emptyMap;

    // add event listeners

    for (final eventType in newEventListenersInCapturePhase.keys) {
      if (!oldEventListenersInCapturePhase.containsKey(eventType)) {
        domNode.addEventListener(eventType, _handleCaptureEvent, true);
      }
    }

    for (final eventType in newEventListenersInBubblePhase.keys) {
      if (!oldEventListenersInBubblePhase.containsKey(eventType)) {
        domNode.addEventListener(eventType, _handleBubbleEvent, false);
      }
    }

    // remove obsolute event listeners

    for (final eventType in oldEventListenersInCapturePhase.keys) {
      if (!newEventListenersInCapturePhase.containsKey(eventType)) {
        domNode.removeEventListener(eventType, _handleCaptureEvent, true);
      }
    }

    for (final eventType in oldEventListenersInBubblePhase.keys) {
      if (!newEventListenersInBubblePhase.containsKey(eventType)) {
        domNode.removeEventListener(eventType, _handleBubbleEvent, false);
      }
    }
  }
}
