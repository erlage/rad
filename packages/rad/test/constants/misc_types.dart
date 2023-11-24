// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

class RT_DirectionTypes {
  static const implemented = ['ltr', 'rtl', 'auto'];
  static const available = ['ltr', 'rtl', 'auto'];
}

class RT_WrapTypes {
  static const implemented = ['hard', 'soft', 'off'];
  static const available = ['hard', 'soft', 'off'];
}

class RT_SpellCheckTypes {
  static const implemented = ['true', 'false', 'default'];
  static const available = ['true', 'false', 'default'];
}

class RT_ScopeTypes {
  static const implemented = ['row', 'col', 'rowgroup', 'colgroup'];
  static const available = ['row', 'col', 'rowgroup', 'colgroup'];
}

class RT_ListTypes {
  static const implemented = ['a', 'A', 'i', 'I', '1'];
  static const available = ['a', 'A', 'i', 'I', '1'];
}

class RT_CrossOriginTypes {
  static const implemented = ['anonymous', 'use-credentials'];
  static const available = ['anonymous', 'use-credentials', ''];
}

class RT_DecodingTypes {
  static const implemented = ['sync', 'async', 'auto'];
  static const available = ['sync', 'async', 'auto'];
}

class RT_LoadingTypes {
  static const implemented = ['eager', 'lazy'];
  static const available = ['eager', 'lazy'];
}

class RT_PreloadTypes {
  static const implemented = ['none', 'metadata', 'auto', ''];
  static const available = ['none', 'metadata', 'auto', ''];
}

class RT_FetchPriorityTypes {
  static const implemented = ['high', 'low', 'auto'];
  static const available = ['high', 'low', 'auto'];
}

class RT_KindTypes {
  static const implemented = [
    'subtitles',
    'captions',
    'descriptions',
    'chapters',
    'metadata',
  ];
  static const available = [
    'subtitles',
    'captions',
    'descriptions',
    'chapters',
    'metadata',
  ];
}

class RT_ReferrerPolicyTypes {
  static const implemented = [
    'no-referrer',
    'no-referrer-when-downgrade',
    'origin',
    'origin-when-cross-origin',
    'same-origin',
    'strict-origin',
    'strict-origin-when-cross-origin',
    'unsafe-url',
  ];
  static const available = [
    'no-referrer',
    'no-referrer-when-downgrade',
    'origin',
    'origin-when-cross-origin',
    'same-origin',
    'strict-origin',
    'strict-origin-when-cross-origin',
    'unsafe-url',
  ];
}
