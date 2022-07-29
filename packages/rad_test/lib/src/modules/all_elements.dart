// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// ignore_for_file: invalid_use_of_internal_member

import 'package:rad_test/src/common/functions.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/cached_iterable.dart';

/// Provides an iterable that efficiently returns all the elements
/// rooted at the given element. See [CachingIterable] for details.
///
/// This method must be called again if the tree changes. You cannot
/// call this function once, then reuse the iterable after having
/// changed the state of the tree, because the iterable returned by
/// this function caches the results and only walks the tree once.
///
/// The same applies to any iterable obtained indirectly through this
/// one, for example the results of calling `where` on this iterable
/// are also cached.
///
Iterable<RenderElement> collectAllWidgetObjectsFrom(
  RenderElement rootElement, {
  required bool skipOffstage,
}) {
  return CachingIterable<RenderElement>(
    _DepthFirstChildIterator(rootElement, skipOffstage),
  );
}

/// Provides a recursive, efficient, depth first search of an element tree.
///
///       1
///     /   \
///    2     3
///   / \   / \
///  4   5 6   7
///
/// Will iterate in order 2, 4, 5, 3, 6, 7.
///
class _DepthFirstChildIterator
    with ServicesResolver
    implements Iterator<RenderElement> {
  _DepthFirstChildIterator(RenderElement rootElement, this.skipOffstage) {
    _fillChildren(rootElement);
  }

  final bool skipOffstage;

  late RenderElement _current;

  final _stack = <RenderElement>[];

  @override
  RenderElement get current => _current;

  @override
  bool moveNext() {
    if (_stack.isEmpty) return false;

    _current = _stack.removeLast();
    _fillChildren(_current);

    return true;
  }

  void _fillChildren(RenderElement element) {
    final List<RenderElement> reversed = <RenderElement>[];

    element.traverseChildElements((child) {
      var childDomNode = child.domNode;

      if (skipOffstage) {
        childDomNode ??= child.findClosestDomNode();

        if (fnIsDomNodeVisible(childDomNode)) {
          reversed.add(child);
        }
      } else {
        reversed.add(child);
      }
    });

    while (reversed.isNotEmpty) {
      _stack.add(reversed.removeLast());
    }
  }
}
