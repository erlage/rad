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

    test('should map to the correct native value', () {
      expect(DirectionType.leftToRight.nativeValue, equals('ltr'));
      expect(DirectionType.rightToLeft.nativeValue, equals('rtl'));
      expect(DirectionType.auto.nativeValue, equals('auto'));
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

    test('should map to the correct native value', () {
      expect(WrapType.hard.nativeValue, equals('hard'));
      expect(WrapType.soft.nativeValue, equals('soft'));
      expect(WrapType.off.nativeValue, equals('off'));
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

    test('should map to the correct native value', () {
      expect(SpellCheckType.trueValue.nativeValue, equals('true'));
      expect(SpellCheckType.falseValue.nativeValue, equals('false'));
      expect(SpellCheckType.defaultValue.nativeValue, equals('default'));
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

    test('should map to the correct native value', () {
      expect(ScopeType.row.nativeValue, equals('row'));
      expect(ScopeType.column.nativeValue, equals('col'));
      expect(ScopeType.rowGroup.nativeValue, equals('rowgroup'));
      expect(ScopeType.columnGroup.nativeValue, equals('colgroup'));
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

    test('should map to the correct native value', () {
      expect(InputType.button.nativeValue, equals('button'));
      expect(InputType.checkbox.nativeValue, equals('checkbox'));
      expect(InputType.color.nativeValue, equals('color'));
      expect(InputType.date.nativeValue, equals('date'));
      expect(InputType.dateTimeLocal.nativeValue, equals('datetime-local'));
      expect(InputType.email.nativeValue, equals('email'));
      expect(InputType.file.nativeValue, equals('file'));
      expect(InputType.hidden.nativeValue, equals('hidden'));
      expect(InputType.image.nativeValue, equals('image'));
      expect(InputType.month.nativeValue, equals('month'));
      expect(InputType.number.nativeValue, equals('number'));
      expect(InputType.password.nativeValue, equals('password'));
      expect(InputType.radio.nativeValue, equals('radio'));
      expect(InputType.range.nativeValue, equals('range'));
      expect(InputType.reset.nativeValue, equals('reset'));
      expect(InputType.search.nativeValue, equals('search'));
      expect(InputType.submit.nativeValue, equals('submit'));
      expect(InputType.telephone.nativeValue, equals('tel'));
      expect(InputType.text.nativeValue, equals('text'));
      expect(InputType.time.nativeValue, equals('time'));
      expect(InputType.url.nativeValue, equals('url'));
      expect(InputType.week.nativeValue, equals('week'));
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

    test('should map to the correct native value', () {
      expect(FormEncType.textPlain.nativeValue, equals('text/plain'));
      expect(
        FormEncType.multipartFormData.nativeValue,
        equals('multipart/form-data'),
      );
      expect(
        FormEncType.applicationXwwwFormUrlEncoded.nativeValue,
        equals('application/x-www-form-urlencoded'),
      );
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

    test('should map to the correct native value', () {
      expect(FormMethodType.get.nativeValue, equals('get'));
      expect(FormMethodType.post.nativeValue, equals('post'));
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

    test('should map to the correct native value', () {
      expect(ButtonType.button.nativeValue, equals('button'));
      expect(ButtonType.reset.nativeValue, equals('reset'));
      expect(ButtonType.submit.nativeValue, equals('submit'));
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

    test('should map to the correct native value', () {
      expect(ListType.lowerCaseLetters.nativeValue, equals('a'));
      expect(ListType.upperCaseLetters.nativeValue, equals('A'));
      expect(ListType.lowerCaseRomanNumerals.nativeValue, equals('i'));
      expect(ListType.upperCaseRomanNumerals.nativeValue, equals('I'));
      expect(ListType.numbers.nativeValue, equals('1'));
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

    test('should map to the correct native value', () {
      expect(CrossOriginType.anonymous.nativeValue, equals('anonymous'));
      expect(
        CrossOriginType.useCredentials.nativeValue,
        equals('use-credentials'),
      );
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

    test('should map to the correct native value', () {
      expect(DecodingType.sync.nativeValue, equals('sync'));
      expect(DecodingType.async.nativeValue, equals('async'));
      expect(DecodingType.auto.nativeValue, equals('auto'));
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

    test('should map to the correct native value', () {
      expect(LoadingType.eager.nativeValue, equals('eager'));
      expect(LoadingType.lazy.nativeValue, equals('lazy'));
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

    test('should map to the correct native value', () {
      expect(PreloadType.none.nativeValue, equals('none'));
      expect(PreloadType.auto.nativeValue, equals('auto'));
      expect(PreloadType.metaData.nativeValue, equals('metadata'));
      expect(PreloadType.empty.nativeValue, equals(''));
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

    test('should map to the correct native value', () {
      expect(FetchPriorityType.high.nativeValue, equals('high'));
      expect(FetchPriorityType.low.nativeValue, equals('low'));
      expect(FetchPriorityType.auto.nativeValue, equals('auto'));
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

    test('should map to the correct native value', () {
      expect(KindType.subtitles.nativeValue, equals('subtitles'));
      expect(KindType.captions.nativeValue, equals('captions'));
      expect(KindType.descriptions.nativeValue, equals('descriptions'));
      expect(KindType.chapters.nativeValue, equals('chapters'));
      expect(KindType.metaData.nativeValue, equals('metadata'));
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

    test('should map to the correct native value', () {
      expect(
        ReferrerPolicyType.noReferrer.nativeValue,
        equals('no-referrer'),
      );
      expect(
        ReferrerPolicyType.noReferrerWhenDowngrade.nativeValue,
        equals('no-referrer-when-downgrade'),
      );
      expect(
        ReferrerPolicyType.origin.nativeValue,
        equals('origin'),
      );
      expect(
        ReferrerPolicyType.originWhenCrossOrigin.nativeValue,
        equals('origin-when-cross-origin'),
      );
      expect(
        ReferrerPolicyType.sameOrigin.nativeValue,
        equals('same-origin'),
      );
      expect(
        ReferrerPolicyType.strictOrigin.nativeValue,
        equals('strict-origin'),
      );
      expect(
        ReferrerPolicyType.strictOriginWhenCrossOrigin.nativeValue,
        equals('strict-origin-when-cross-origin'),
      );
      expect(
        ReferrerPolicyType.unSafeUrl.nativeValue,
        equals('unsafe-url'),
      );
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

    test('should map to the correct native value', () {
      expect(DomEventType.click.nativeValue, equals('click'));
      expect(DomEventType.doubleClick.nativeValue, equals('dblclick'));
      expect(DomEventType.change.nativeValue, equals('change'));
      expect(DomEventType.input.nativeValue, equals('input'));
      expect(DomEventType.submit.nativeValue, equals('submit'));
      expect(DomEventType.keyUp.nativeValue, equals('keyup'));
      expect(DomEventType.keyDown.nativeValue, equals('keydown'));
      expect(DomEventType.keyPress.nativeValue, equals('keypress'));
      expect(DomEventType.drag.nativeValue, equals('drag'));
      expect(DomEventType.dragEnd.nativeValue, equals('dragend'));
      expect(DomEventType.dragEnter.nativeValue, equals('dragenter'));
      expect(DomEventType.dragLeave.nativeValue, equals('dragleave'));
      expect(DomEventType.dragOver.nativeValue, equals('dragover'));
      expect(DomEventType.dragStart.nativeValue, equals('dragstart'));
      expect(DomEventType.drop.nativeValue, equals('drop'));
      expect(DomEventType.mouseDown.nativeValue, equals('mousedown'));
      expect(DomEventType.mouseEnter.nativeValue, equals('mouseenter'));
      expect(DomEventType.mouseLeave.nativeValue, equals('mouseleave'));
      expect(DomEventType.mouseMove.nativeValue, equals('mousemove'));
      expect(DomEventType.mouseOver.nativeValue, equals('mouseover'));
      expect(DomEventType.mouseOut.nativeValue, equals('mouseout'));
      expect(DomEventType.mouseUp.nativeValue, equals('mouseup'));
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

    test('should map to the correct native value', () {
      expect(DomTagType.anchor.nativeValue, equals('a'));
      expect(DomTagType.abbreviation.nativeValue, equals('abbr'));
      expect(DomTagType.address.nativeValue, equals('address'));
      expect(DomTagType.imageMapArea.nativeValue, equals('area'));
      expect(DomTagType.article.nativeValue, equals('article'));
      expect(DomTagType.aside.nativeValue, equals('aside'));
      expect(DomTagType.audio.nativeValue, equals('audio'));
      expect(DomTagType.bidirectionalIsolate.nativeValue, equals('bdi'));
      expect(DomTagType.bidirectionalTextOverride.nativeValue, equals('bdo'));
      expect(DomTagType.blockQuote.nativeValue, equals('blockquote'));
      expect(DomTagType.lineBreak.nativeValue, equals('br'));
      expect(DomTagType.button.nativeValue, equals('button'));
      expect(DomTagType.canvas.nativeValue, equals('canvas'));
      expect(DomTagType.caption.nativeValue, equals('caption'));
      expect(DomTagType.citation.nativeValue, equals('cite'));
      expect(DomTagType.code.nativeValue, equals('code'));
      expect(DomTagType.tableColumn.nativeValue, equals('col'));
      expect(DomTagType.tableColumnGroup.nativeValue, equals('colgroup'));
      expect(DomTagType.data.nativeValue, equals('data'));
      expect(DomTagType.dataList.nativeValue, equals('datalist'));
      expect(DomTagType.descriptionDetails.nativeValue, equals('dd'));
      expect(DomTagType.deletedText.nativeValue, equals('del'));
      expect(DomTagType.details.nativeValue, equals('details'));
      expect(DomTagType.definition.nativeValue, equals('dfn'));
      expect(DomTagType.dialog.nativeValue, equals('dialog'));
      expect(DomTagType.division.nativeValue, equals('div'));
      expect(DomTagType.descriptionList.nativeValue, equals('dl'));
      expect(DomTagType.descriptionTerm.nativeValue, equals('dt'));
      expect(DomTagType.emphasis.nativeValue, equals('em'));
      expect(DomTagType.embedExternal.nativeValue, equals('embed'));
      expect(DomTagType.fieldSet.nativeValue, equals('fieldset'));
      expect(DomTagType.figureCaption.nativeValue, equals('figcaption'));
      expect(DomTagType.figure.nativeValue, equals('figure'));
      expect(DomTagType.footer.nativeValue, equals('footer'));
      expect(DomTagType.form.nativeValue, equals('form'));
      expect(DomTagType.heading1.nativeValue, equals('h1'));
      expect(DomTagType.heading2.nativeValue, equals('h2'));
      expect(DomTagType.heading3.nativeValue, equals('h3'));
      expect(DomTagType.heading4.nativeValue, equals('h4'));
      expect(DomTagType.heading5.nativeValue, equals('h5'));
      expect(DomTagType.heading6.nativeValue, equals('h6'));
      expect(DomTagType.header.nativeValue, equals('header'));
      expect(DomTagType.horizontalRule.nativeValue, equals('hr'));
      expect(DomTagType.idiomatic.nativeValue, equals('i'));
      expect(DomTagType.iFrame.nativeValue, equals('iframe'));
      expect(DomTagType.image.nativeValue, equals('img'));
      expect(DomTagType.input.nativeValue, equals('input'));
      expect(DomTagType.insertedText.nativeValue, equals('ins'));
      expect(DomTagType.keyboardInput.nativeValue, equals('kbd'));
      expect(DomTagType.label.nativeValue, equals('label'));
      expect(DomTagType.legend.nativeValue, equals('legend'));
      expect(DomTagType.listItem.nativeValue, equals('li'));
      expect(DomTagType.imageMap.nativeValue, equals('map'));
      expect(DomTagType.markText.nativeValue, equals('mark'));
      expect(DomTagType.menu.nativeValue, equals('menu'));
      expect(DomTagType.meter.nativeValue, equals('meter'));
      expect(DomTagType.navigation.nativeValue, equals('nav'));
      expect(DomTagType.orderedList.nativeValue, equals('ol'));
      expect(DomTagType.optionGroup.nativeValue, equals('optgroup'));
      expect(DomTagType.option.nativeValue, equals('option'));
      expect(DomTagType.output.nativeValue, equals('output'));
      expect(DomTagType.paragraph.nativeValue, equals('p'));
      expect(DomTagType.picture.nativeValue, equals('picture'));
      expect(DomTagType.portal.nativeValue, equals('portal'));
      expect(DomTagType.preformattedText.nativeValue, equals('pre'));
      expect(DomTagType.progress.nativeValue, equals('progress'));
      expect(DomTagType.inlineQuotation.nativeValue, equals('q'));
      expect(DomTagType.rubyFallbackParenthesis.nativeValue, equals('rp'));
      expect(DomTagType.rubyText.nativeValue, equals('rt'));
      expect(DomTagType.rubyAnnotation.nativeValue, equals('ruby'));
      expect(DomTagType.strikeThrough.nativeValue, equals('s'));
      expect(DomTagType.sampleOutput.nativeValue, equals('samp'));
      expect(DomTagType.select.nativeValue, equals('select'));
      expect(DomTagType.small.nativeValue, equals('small'));
      expect(DomTagType.mediaSource.nativeValue, equals('source'));
      expect(DomTagType.span.nativeValue, equals('span'));
      expect(DomTagType.strong.nativeValue, equals('strong'));
      expect(DomTagType.subScript.nativeValue, equals('sub'));
      expect(DomTagType.summary.nativeValue, equals('summary'));
      expect(DomTagType.superScript.nativeValue, equals('sup'));
      expect(DomTagType.table.nativeValue, equals('table'));
      expect(DomTagType.tableBody.nativeValue, equals('tbody'));
      expect(DomTagType.tableDataCell.nativeValue, equals('td'));
      expect(DomTagType.textArea.nativeValue, equals('textarea'));
      expect(DomTagType.tableFoot.nativeValue, equals('tfoot'));
      expect(DomTagType.tableHeaderCell.nativeValue, equals('th'));
      expect(DomTagType.tableHead.nativeValue, equals('thead'));
      expect(DomTagType.time.nativeValue, equals('time'));
      expect(DomTagType.tableRow.nativeValue, equals('tr'));
      expect(DomTagType.embedTextTrack.nativeValue, equals('track'));
      expect(DomTagType.unOrderedList.nativeValue, equals('ul'));
      expect(DomTagType.variable.nativeValue, equals('var'));
      expect(DomTagType.video.nativeValue, equals('video'));
      expect(DomTagType.lineBreakOpportunity.nativeValue, equals('wbr'));
    });
  });
}
