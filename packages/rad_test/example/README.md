### Sample usage

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
