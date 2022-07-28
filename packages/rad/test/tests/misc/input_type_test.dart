// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  test('should set correct input types', () {
    expect(InputButton().type?.nativeValue, equals('button'));
    expect(InputCheckBox().type?.nativeValue, equals('checkbox'));
    expect(InputColor().type?.nativeValue, equals('color'));
    expect(InputDate().type?.nativeValue, equals('date'));
    expect(InputDateTimeLocal().type?.nativeValue, equals('datetime-local'));
    expect(InputEmail().type?.nativeValue, equals('email'));
    expect(InputFile().type?.nativeValue, equals('file'));
    expect(InputHidden().type?.nativeValue, equals('hidden'));
    expect(InputImage().type?.nativeValue, equals('image'));
    expect(InputMonth().type?.nativeValue, equals('month'));
    expect(InputNumber().type?.nativeValue, equals('number'));
    expect(InputPassword().type?.nativeValue, equals('password'));
    expect(InputRadio().type?.nativeValue, equals('radio'));
    expect(InputRange().type?.nativeValue, equals('range'));
    expect(InputReset().type?.nativeValue, equals('reset'));
    expect(InputSearch().type?.nativeValue, equals('search'));
    expect(InputSubmit().type?.nativeValue, equals('submit'));
    expect(InputTelephone().type?.nativeValue, equals('tel'));
    expect(InputText().type?.nativeValue, equals('text'));
    expect(InputTime().type?.nativeValue, equals('time'));
    expect(InputUrl().type?.nativeValue, equals('url'));
    expect(InputWeek().type?.nativeValue, equals('week'));
  });
}
