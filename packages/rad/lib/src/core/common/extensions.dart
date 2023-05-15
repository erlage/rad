import 'package:meta/meta.dart';

import 'package:rad/rad.dart';

/// @nodoc
@internal
extension RenderElementAPIs on RenderElement {
  bool get frameworkIsDetached {
    return !frameworkIsRootReachable;
  }

  bool get frameworkIsRootReachable {
    if (frameworkIsRoot) {
      return true;
    }

    RenderElement? ancestor = frameworkParent;
    while (null != ancestor) {
      if (ancestor.frameworkIsRoot) {
        return true;
      }

      ancestor = ancestor.frameworkParent;
    }

    return false;
  }
}
