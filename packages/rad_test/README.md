## Rad - Testing library

A testing library for Rad applications, heavly inspired from [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) with number of new APIs for testing applications that are written using [Rad](https://github.com/erlage/rad).


### Example usage

```dart
import 'package:rad_test/rad_test.dart';

import 'app.dart';

void main() {
  group('basic widget test', () {
    testWidgets('should build text widget', (WidgetTester tester) async {
      
      await tester.pumpWidget(Text('hello world'));

      expect(tester.find.text('hello world'), findsOneWidget);
    });
  });
}
```

### License

Source is governed by a BSD-style license that can be found in LICENSE file. Parts of source code in this library are borrowed from flutter testing library which is also governed by a BSD-style license that can be found [here](https://github.com/flutter/flutter/blob/master/LICENSE).

