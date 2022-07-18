// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  group('DirectionType', () {
    test('should be available', () {
      for (final eventType in DirectionType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_DirectionTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final eventType in DirectionType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_DirectionTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final eventType in DirectionType.values) {
        expect(eventType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('WrapType', () {
    test('should be available', () {
      for (final eventType in WrapType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_WrapTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final eventType in WrapType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_WrapTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final eventType in WrapType.values) {
        expect(eventType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('SpellCheckType', () {
    test('should be available', () {
      for (final eventType in SpellCheckType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_SpellCheckTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final eventType in SpellCheckType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_SpellCheckTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final eventType in SpellCheckType.values) {
        expect(eventType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('ScopeType', () {
    test('should be available', () {
      for (final eventType in ScopeType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_ScopeTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final eventType in ScopeType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_ScopeTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final eventType in ScopeType.values) {
        expect(eventType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('InputType', () {
    test('should be available', () {
      for (final inputType in InputType.values) {
        expect(
          inputType.nativeValue,
          RT_IsInKnownItems<String>(RT_InputTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final inputType in InputType.values) {
        expect(
          inputType.nativeValue,
          RT_IsInKnownItems<String>(RT_InputTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final inputType in InputType.values) {
        expect(inputType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('FormEncType', () {
    test('should be available', () {
      for (final enctype in FormEncType.values) {
        expect(
          enctype.nativeValue,
          RT_IsInKnownItems<String>(RT_FormTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final enctype in FormEncType.values) {
        expect(
          enctype.nativeValue,
          RT_IsInKnownItems<String>(RT_FormTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final enctype in FormEncType.values) {
        expect(enctype.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('FormMethodType', () {
    test('should be available', () {
      for (final method in FormMethodType.values) {
        expect(
          method.nativeValue,
          RT_IsInKnownItems<String>(RT_FormMethods.available),
        );
      }
    });

    test('should be implemented', () {
      for (final method in FormMethodType.values) {
        expect(
          method.nativeValue,
          RT_IsInKnownItems<String>(RT_FormMethods.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final method in FormMethodType.values) {
        expect(method.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('ButtonType', () {
    test('should be available', () {
      for (final buttonType in ButtonType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ButtonTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in ButtonType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ButtonTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in ButtonType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('ListType', () {
    test('should be available', () {
      for (final buttonType in ListType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ListTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in ListType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ListTypes.implemented),
        );
      }
    });
  });

  group('CrossOriginType', () {
    test('should be available', () {
      for (final buttonType in CrossOriginType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_CrossOriginTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in CrossOriginType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_CrossOriginTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in CrossOriginType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('DecodingType', () {
    test('should be available', () {
      for (final buttonType in DecodingType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_DecodingTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in DecodingType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_DecodingTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in DecodingType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('LoadingType', () {
    test('should be available', () {
      for (final buttonType in LoadingType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_LoadingTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in LoadingType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_LoadingTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in LoadingType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('PreloadType', () {
    test('should be available', () {
      for (final buttonType in PreloadType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_PreloadTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in PreloadType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_PreloadTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in PreloadType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('FetchPriorityType', () {
    test('should be available', () {
      for (final buttonType in FetchPriorityType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_FetchPriorityTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in FetchPriorityType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_FetchPriorityTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in FetchPriorityType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('KindType', () {
    test('should be available', () {
      for (final buttonType in KindType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_KindTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in KindType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_KindTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in KindType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('ReferrerPolicyType', () {
    test('should be available', () {
      for (final buttonType in ReferrerPolicyType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ReferrerPolicyTypes.available),
        );
      }
    });

    test('should be implemented', () {
      for (final buttonType in ReferrerPolicyType.values) {
        expect(
          buttonType.nativeValue,
          RT_IsInKnownItems<String>(RT_ReferrerPolicyTypes.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final buttonType in ReferrerPolicyType.values) {
        expect(buttonType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('DomEventType', () {
    test('should be available', () {
      for (final eventType in DomEventType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_DomEvents.available),
        );
      }
    });

    test('should be implemented', () {
      for (final eventType in DomEventType.values) {
        expect(
          eventType.nativeValue,
          RT_IsInKnownItems<String>(RT_DomEvents.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final eventType in DomEventType.values) {
        expect(eventType.nativeValue, RT_IsLowerCase());
      }
    });
  });

  group('DomTagType', () {
    test('should be available', () {
      for (final domTag in DomTagType.values) {
        expect(
          domTag.nativeValue,
          RT_IsInKnownItems<String>(RT_DomTags.available),
        );
      }
    });

    test('should be implemented', () {
      for (final domNodeType in DomTagType.values) {
        expect(
          domNodeType.nativeValue,
          RT_IsInKnownItems<String>(RT_DomTags.implemented),
        );
      }
    });

    test('should be lowercase', () {
      for (final domTag in DomTagType.values) {
        expect(domTag.nativeValue, RT_IsLowerCase());
      }
    });

    test('should be without space', () {
      for (final domNodeType in DomTagType.values) {
        expect(domNodeType.nativeValue, RT_IsWithoutSpace());
      }
    });
  });
}
