## Rad - Testing library

A testing library for Rad applications, heavily inspired from [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html).

[![Rad(test-pkg)](https://github.com/erlage/rad/actions/workflows/rad_test_pkg.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/rad_test_pkg.yml)

### Example usage

```dart
import 'package:rad_test/rad_test.dart';

import 'app.dart';

void main() {
  testWidgets('should build text widget', (WidgetTester tester) async {
    await tester.pumpWidget(Text('hello world'));

    expect(tester.find.text('hello world'), findsOneWidget);
  });
}
```

For more please checkout [examples here](https://github.com/erlage/rad/tree/main/packages/rad/test/tests/framework).

### License

Source is governed by a BSD-style license that can be found in LICENSE file. Parts of source code in this library are borrowed from flutter-testing library which are also governed by a BSD-style license that can be found [here](https://github.com/flutter/flutter/blob/master/LICENSE).

