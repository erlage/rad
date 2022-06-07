### Sample usage

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
