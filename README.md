# Rad

Rad is a frontend framework for creating fast and interactive web apps using Dart. It has all the best bits of Flutter(StatefulWidgets, Builders) and React(Hooks, Performance), and allows you to use web technologies(HTML and CSS) in your app.

[![Rad(core)](https://github.com/erlage/rad/actions/workflows/rad_core.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/rad_core.yml)
[![Reconciler](https://github.com/erlage/rad/actions/workflows/reconciler.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/reconciler.yml)
[![codecov](https://codecov.io/gh/erlage/rad/branch/main/graph/badge.svg?token=PbTQU0aSDn)](https://codecov.io/gh/erlage/rad)
[![pub version](https://img.shields.io/pub/v/rad?color=6CB4EE)](https://pub.dev/packages/rad)

## Quick links

- [Getting started](https://github.com/erlage/rad/blob/main/doc/getting_started.md)
- [Package @ pub.dev](https://pub.dev/packages/rad)
- [API reference @ pub.dev](https://pub.dev/documentation/rad/latest/rad/rad-library.html)
- [Repository @ github.com](https://github.com/erlage/rad)
- [Benchmarks @ github.com](https://github.com/erlage/rad-benchmarks)
- [Additional Packages & Tools](#additional-packagestools)

## Example

```dart
void main() {
  runApp(
    app: Text('hello world'),
    appTargetId: 'output',
  );
}
```

Function `runApp` will finds a element having `id=output` in your HTML page, create a Rad app with it, and then displays "hello world" inside of it. As you might have guessed it, `Text('hello world')` is a widget, a special purpose widget provided by the framework that we're using to display desired text on the screen. Rad provides number of widgets that you can use and best thing about widgets is that you can compose them together to create more widgets and build complex layouts.

## Flutter widgets

Following widgets in Rad are inspired from Flutter:

- [InheritedWidget](https://pub.dev/documentation/rad/latest/rad/InheritedWidget-class.html), [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html) and [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html).
- [FutureBuilder](https://pub.dev/documentation/rad/latest/widgets_async/FutureBuilder-class.html), [StreamBuilder](https://pub.dev/documentation/rad/latest/widgets_async/StreamBuilder-class.html) and [ValueListenableBuilder](https://pub.dev/documentation/rad/latest/widgets_async/ValueListenableBuilder-class.html).

These widgets has same syntax as their Flutter's counterparts. Not just syntax, they also works exactly same as if they would in Flutter. Which means you don't have to learn anything new to be able to use them.

## React hooks

Similar to React, we have number of hooks that you can use to power-up your widget functions.

Let's see a basic example with [useState](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useState.html):

```dart
Widget widgetFunction() => HookScope(() {
  // create a stateful value
  var state = useState(0);

  return Span(
    child: Text('You clicked me ${state.value} time!'),
    onClick: (_) => state.value++,
  );
});

runApp(app: widgetFunction(), ...);
```

While using hooks please keep in mind following things,

1. Avoid calling Hooks inside loops, conditions, or nested functions.
2. Always wrap body of your Widget-functions with a [HookScope](https://pub.dev/documentation/rad/latest/rad/HookScope.html) widget.
3. Always use Hooks at the top level of your functions, before any widget/or early return.

## HTML widgets

Rad provides you with more than 100 widgets that are dedicated to help you write HTML within your Dart code as easily as possible.

Let's look at this markup example:

```html
<div>
  <p>Hey there!</p>
</div>
```

Here's how we'll write this using HTML widgets:

```dart
Division(
  children: [
    Paragraph(innerText: 'Hey there!'),
  ]
)
```

There's also an alternative syntax for all HTML widgets:

```dart
div(
  children: [
    p(innerText: 'Hey there!'),
  ]
)
```

Apart from syntax/names, HTML widgets are composable and has same semantics in the sense that they can be composed and mixed together with other widgets. For example,

```dart
Span(
  child: ListView(
    children: [
      SomeStatefulWidget(),
      Span(),
      ...
    ]
  ),
);
```

In above example, a [Span](https://pub.dev/documentation/rad/latest/widgets_html/Span-class.html) widget is containing a [ListView](https://pub.dev/documentation/rad/latest/rad/ListView-class.html) widget. Further, that [ListView](https://pub.dev/documentation/rad/latest/rad/ListView-class.html) is containing a [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html) and a [Span](https://pub.dev/documentation/rad/latest/widgets_html/Span-class.html) widget. The point we're trying to make is that HTML widgets won't restrict you to 'just HTML'.

## Additional Packages/Tools

### [Rad Test](https://pub.dev/packages/rad_test) (package)

A testing library for Rad applications, heavily inspired from [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html).

### [Rad Hooks](https://pub.dev/packages/rad_hooks) (package)

A set of commonly used hooks for using in your Rad applications.

### [Rad Extension](https://marketplace.visualstudio.com/items?itemName=erlage.rad) (for VSCode)

Provides an enhanced development experience for developers working with the Rad Framework. With its powerful features, this extension makes it easier for developers to write and manage code, saving time and increasing productivity. Extension's top features are:

- **Visual JSX**: Transforms your HTML widgets into a visually appealing, JSX-like syntax.
  <details>
    <summary>Click to See Preview</summary>
    
    ![Visual-JSX Preview](https://github.com/erlage/rad/blob/47591df594be5d993d5a813667ef9d372ec80f10/packages/text_editor_vscode_extension/art/peek1.gif?raw=true)
  </details>

- **HTML2Rad**: Converts your HTML markup directly into Rad's HTML widgets.
  <details>
    <summary>Click to See Preview</summary>
    
    ![HTML2Rad Preview](https://github.com/erlage/rad/blob/47591df594be5d993d5a813667ef9d372ec80f10/packages/text_editor_vscode_extension/art/peek2.gif?raw=true)
  </details>

## Reference

Below is the list of available widgets and hooks in Rad. Some widgets are named after Flutter widgets because they either works exactly same or can be used to achieve same things but in a different way(more or less). All those widgets are tagged accordingly.

Tags:

- **_exact_**: Exact syntax, similar semantics.
- **_same_**: Exact syntax with few exceptions, similar semantics.
- **_different_**: Different syntax, different semantics.
- **_untested_**: --

### Abstract

- [InheritedWidget](https://pub.dev/documentation/rad/latest/rad/InheritedWidget-class.html) \[_similar_\]
- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html) \[_similar_\]
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html) \[_similar_\]

### Navigator/Routing

- [Navigator](https://pub.dev/documentation/rad/latest/rad/Navigator-class.html) \[_different_\]
- [Route](https://pub.dev/documentation/rad/latest/rad/Route-class.html) \[_different_\]
- [AsyncRoute](https://pub.dev/documentation/rad/latest/rad/AsyncRoute-class.html)

### Builders

- [FutureBuilder](https://pub.dev/documentation/rad/latest/widgets_async/FutureBuilder-class.html) \[_exact_\]
- [StreamBuilder](https://pub.dev/documentation/rad/latest/widgets_async/StreamBuilder-class.html) \[_exact_\]
- [ValueListenableBuilder](https://pub.dev/documentation/rad/latest/widgets_async/ValueListenableBuilder-class.html) \[_exact_\]
- [ListView.builder](https://pub.dev/documentation/rad/latest/rad/ListView/ListView.builder.html) \[_same_, _untested_\]

### Functional

- [RadApp](https://pub.dev/documentation/rad/latest/rad/RadApp-class.html)
- [Text](https://pub.dev/documentation/rad/latest/rad/Text-class.html) \[_different_\]
- [ListView](https://pub.dev/documentation/rad/latest/rad/ListView-class.html) \[_same_\]
- [HookScope](https://pub.dev/documentation/rad/latest/rad/HookScope.html)
- [EventDetector](https://pub.dev/documentation/rad/latest/rad/EventDetector-class.html)
- [GestureDetector](https://pub.dev/documentation/rad/latest/rad/GestureDetector-class.html) \[_same_\]

### Misc

- [RawMarkUp](https://pub.dev/documentation/rad/latest/rad/RawMarkUp-class.html)
- [RawEventDetector](https://pub.dev/documentation/rad/latest/rad/RawEventDetector-class.html)

### Hooks

[useContext](https://pub.dev/documentation/rad/latest/rad/useContext.html)
, [useNavigator](https://pub.dev/documentation/rad/latest/rad/useNavigator.html)
, [useRef](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useRef.html)
, [useState](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useState.html)
, [useMemo](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useMemo.html)
, [useCallback](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useCallback.html)
, [useEffect](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useEffect.html)
, [useLayoutEffect](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useLayoutEffect.html)

### HTML Widgets (additional)

[InputButton](https://pub.dev/documentation/rad/latest/widgets_html/InputButton-class.html)
, [InputCheckBox](https://pub.dev/documentation/rad/latest/widgets_html/InputCheckBox-class.html)
, [InputColor](https://pub.dev/documentation/rad/latest/widgets_html/InputColor-class.html)
, [InputDate](https://pub.dev/documentation/rad/latest/widgets_html/InputDate-class.html)
, [InputDateTimeLocal](https://pub.dev/documentation/rad/latest/widgets_html/InputDateTimeLocal-class.html)
, [InputEmail](https://pub.dev/documentation/rad/latest/widgets_html/InputEmail-class.html)
, [InputFile](https://pub.dev/documentation/rad/latest/widgets_html/InputFile-class.html)
, [InputImage](https://pub.dev/documentation/rad/latest/widgets_html/InputImage-class.html)
, [InputMonth](https://pub.dev/documentation/rad/latest/widgets_html/InputMonth-class.html)
, [InputNumber](https://pub.dev/documentation/rad/latest/widgets_html/InputNumber-class.html)
, [InputPassword](https://pub.dev/documentation/rad/latest/widgets_html/InputPassword-class.html)
, [InputRadio](https://pub.dev/documentation/rad/latest/widgets_html/InputRadio-class.html)
, [InputRange](https://pub.dev/documentation/rad/latest/widgets_html/InputRange-class.html)
, [InputReset](https://pub.dev/documentation/rad/latest/widgets_html/InputReset-class.html)
, [InputSearch](https://pub.dev/documentation/rad/latest/widgets_html/InputSearch-class.html)
, [InputSubmit](https://pub.dev/documentation/rad/latest/widgets_html/InputSubmit-class.html)
, [InputTelephone](https://pub.dev/documentation/rad/latest/widgets_html/InputTelephone-class.html)
, [InputText](https://pub.dev/documentation/rad/latest/widgets_html/InputText-class.html)
, [InputTime](https://pub.dev/documentation/rad/latest/widgets_html/InputTime-class.html)
, [InputUrl](https://pub.dev/documentation/rad/latest/widgets_html/InputUrl-class.html)
, [InputWeek](https://pub.dev/documentation/rad/latest/widgets_html/InputWeek-class.html)

### HTML Widgets (short-syntax)

[a](https://pub.dev/documentation/rad/latest/widgets_short_tags/a.html)
, [abbr](https://pub.dev/documentation/rad/latest/widgets_short_tags/abbr.html)
, [address](https://pub.dev/documentation/rad/latest/widgets_short_tags/address.html)
, [area](https://pub.dev/documentation/rad/latest/widgets_short_tags/area.html)
, [article](https://pub.dev/documentation/rad/latest/widgets_short_tags/article.html)
, [aside](https://pub.dev/documentation/rad/latest/widgets_short_tags/aside.html)
, [audio](https://pub.dev/documentation/rad/latest/widgets_short_tags/audio.html)
, [bdi](https://pub.dev/documentation/rad/latest/widgets_short_tags/bdi.html)
, [bdo](https://pub.dev/documentation/rad/latest/widgets_short_tags/bdo.html)
, [blockquote](https://pub.dev/documentation/rad/latest/widgets_short_tags/blockquote.html)
, [br](https://pub.dev/documentation/rad/latest/widgets_short_tags/br.html)
, [button](https://pub.dev/documentation/rad/latest/widgets_short_tags/button.html)
, [canvas](https://pub.dev/documentation/rad/latest/widgets_short_tags/canvas.html)
, [caption](https://pub.dev/documentation/rad/latest/widgets_short_tags/caption.html)
, [cite](https://pub.dev/documentation/rad/latest/widgets_short_tags/cite.html)
, [code](https://pub.dev/documentation/rad/latest/widgets_short_tags/code.html)
, [col](https://pub.dev/documentation/rad/latest/widgets_short_tags/col.html)
, [colgroup](https://pub.dev/documentation/rad/latest/widgets_short_tags/colgroup.html)
, [data](https://pub.dev/documentation/rad/latest/widgets_short_tags/data.html)
, [datalist](https://pub.dev/documentation/rad/latest/widgets_short_tags/datalist.html)
, [dd](https://pub.dev/documentation/rad/latest/widgets_short_tags/dd.html)
, [del](https://pub.dev/documentation/rad/latest/widgets_short_tags/del.html)
, [details](https://pub.dev/documentation/rad/latest/widgets_short_tags/details.html)
, [dfn](https://pub.dev/documentation/rad/latest/widgets_short_tags/dfn.html)
, [dialog](https://pub.dev/documentation/rad/latest/widgets_short_tags/dialog.html)
, [div](https://pub.dev/documentation/rad/latest/widgets_short_tags/div.html)
, [dl](https://pub.dev/documentation/rad/latest/widgets_short_tags/dl.html)
, [dt](https://pub.dev/documentation/rad/latest/widgets_short_tags/dt.html)
, [em](https://pub.dev/documentation/rad/latest/widgets_short_tags/em.html)
, [embed](https://pub.dev/documentation/rad/latest/widgets_short_tags/embed.html)
, [fieldset](https://pub.dev/documentation/rad/latest/widgets_short_tags/fieldset.html)
, [figcaption](https://pub.dev/documentation/rad/latest/widgets_short_tags/figcaption.html)
, [figure](https://pub.dev/documentation/rad/latest/widgets_short_tags/figure.html)
, [footer](https://pub.dev/documentation/rad/latest/widgets_short_tags/footer.html)
, [form](https://pub.dev/documentation/rad/latest/widgets_short_tags/form.html)
, [h1](https://pub.dev/documentation/rad/latest/widgets_short_tags/h1.html)
, [h2](https://pub.dev/documentation/rad/latest/widgets_short_tags/h2.html)
, [h3](https://pub.dev/documentation/rad/latest/widgets_short_tags/h3.html)
, [h4](https://pub.dev/documentation/rad/latest/widgets_short_tags/h4.html)
, [h5](https://pub.dev/documentation/rad/latest/widgets_short_tags/h5.html)
, [h6](https://pub.dev/documentation/rad/latest/widgets_short_tags/h6.html)
, [header](https://pub.dev/documentation/rad/latest/widgets_short_tags/header.html)
, [hr](https://pub.dev/documentation/rad/latest/widgets_short_tags/hr.html)
, [i](https://pub.dev/documentation/rad/latest/widgets_short_tags/i.html)
, [iframe](https://pub.dev/documentation/rad/latest/widgets_short_tags/iframe.html)
, [img](https://pub.dev/documentation/rad/latest/widgets_short_tags/img.html)
, [input](https://pub.dev/documentation/rad/latest/widgets_short_tags/input.html)
, [ins](https://pub.dev/documentation/rad/latest/widgets_short_tags/ins.html)
, [kbd](https://pub.dev/documentation/rad/latest/widgets_short_tags/kbd.html)
, [label](https://pub.dev/documentation/rad/latest/widgets_short_tags/label.html)
, [legend](https://pub.dev/documentation/rad/latest/widgets_short_tags/legend.html)
, [li](https://pub.dev/documentation/rad/latest/widgets_short_tags/li.html)
, [map](https://pub.dev/documentation/rad/latest/widgets_short_tags/map.html)
, [mark](https://pub.dev/documentation/rad/latest/widgets_short_tags/mark.html)
, [menu](https://pub.dev/documentation/rad/latest/widgets_short_tags/menu.html)
, [meter](https://pub.dev/documentation/rad/latest/widgets_short_tags/meter.html)
, [nav](https://pub.dev/documentation/rad/latest/widgets_short_tags/nav.html)
, [ol](https://pub.dev/documentation/rad/latest/widgets_short_tags/ol.html)
, [optgroup](https://pub.dev/documentation/rad/latest/widgets_short_tags/optgroup.html)
, [option](https://pub.dev/documentation/rad/latest/widgets_short_tags/option.html)
, [output](https://pub.dev/documentation/rad/latest/widgets_short_tags/output.html)
, [p](https://pub.dev/documentation/rad/latest/widgets_short_tags/p.html)
, [picture](https://pub.dev/documentation/rad/latest/widgets_short_tags/picture.html)
, [portal](https://pub.dev/documentation/rad/latest/widgets_short_tags/portal.html)
, [pre](https://pub.dev/documentation/rad/latest/widgets_short_tags/pre.html)
, [progress](https://pub.dev/documentation/rad/latest/widgets_short_tags/progress.html)
, [q](https://pub.dev/documentation/rad/latest/widgets_short_tags/q.html)
, [rp](https://pub.dev/documentation/rad/latest/widgets_short_tags/rp.html)
, [rt](https://pub.dev/documentation/rad/latest/widgets_short_tags/rt.html)
, [ruby](https://pub.dev/documentation/rad/latest/widgets_short_tags/ruby.html)
, [s](https://pub.dev/documentation/rad/latest/widgets_short_tags/s.html)
, [samp](https://pub.dev/documentation/rad/latest/widgets_short_tags/samp.html)
, [section](https://pub.dev/documentation/rad/latest/widgets_short_tags/section.html)
, [select](https://pub.dev/documentation/rad/latest/widgets_short_tags/select.html)
, [small](https://pub.dev/documentation/rad/latest/widgets_short_tags/small.html)
, [source](https://pub.dev/documentation/rad/latest/widgets_short_tags/source.html)
, [span](https://pub.dev/documentation/rad/latest/widgets_short_tags/span.html)
, [strong](https://pub.dev/documentation/rad/latest/widgets_short_tags/strong.html)
, [sub](https://pub.dev/documentation/rad/latest/widgets_short_tags/sub.html)
, [summary](https://pub.dev/documentation/rad/latest/widgets_short_tags/summary.html)
, [sup](https://pub.dev/documentation/rad/latest/widgets_short_tags/sup.html)
, [table](https://pub.dev/documentation/rad/latest/widgets_short_tags/table.html)
, [tbody](https://pub.dev/documentation/rad/latest/widgets_short_tags/tbody.html)
, [td](https://pub.dev/documentation/rad/latest/widgets_short_tags/td.html)
, [textarea](https://pub.dev/documentation/rad/latest/widgets_short_tags/textarea.html)
, [tfoot](https://pub.dev/documentation/rad/latest/widgets_short_tags/tfoot.html)
, [th](https://pub.dev/documentation/rad/latest/widgets_short_tags/th.html)
, [thead](https://pub.dev/documentation/rad/latest/widgets_short_tags/thead.html)
, [time](https://pub.dev/documentation/rad/latest/widgets_short_tags/time.html)
, [tr](https://pub.dev/documentation/rad/latest/widgets_short_tags/tr.html)
, [track](https://pub.dev/documentation/rad/latest/widgets_short_tags/track.html)
, [ul](https://pub.dev/documentation/rad/latest/widgets_short_tags/ul.html)
, [vartag](https://pub.dev/documentation/rad/latest/widgets_short_tags/vartag.html)
, [video](https://pub.dev/documentation/rad/latest/widgets_short_tags/video.html)
, [wbr](https://pub.dev/documentation/rad/latest/widgets_short_tags/wbr.html)

### HTML Widgets (full-syntax)

[Anchor](https://pub.dev/documentation/rad/latest/widgets_html/Anchor-class.html)
, [Abbreviation](https://pub.dev/documentation/rad/latest/widgets_html/Abbreviation-class.html)
, [Address](https://pub.dev/documentation/rad/latest/widgets_html/Address-class.html)
, [Article](https://pub.dev/documentation/rad/latest/widgets_html/Article-class.html)
, [Aside](https://pub.dev/documentation/rad/latest/widgets_html/Aside-class.html)
, [Audio](https://pub.dev/documentation/rad/latest/widgets_html/Audio-class.html)
, [BidirectionalIsolate](https://pub.dev/documentation/rad/latest/widgets_html/BidirectionalIsolate-class.html)
, [BidirectionalTextOverride](https://pub.dev/documentation/rad/latest/widgets_html/BidirectionalTextOverride-class.html)
, [BlockQuote](https://pub.dev/documentation/rad/latest/widgets_html/BlockQuote-class.html)
, [Button](https://pub.dev/documentation/rad/latest/widgets_html/Button-class.html)
, [Canvas](https://pub.dev/documentation/rad/latest/widgets_html/Canvas-class.html)
, [Citation](https://pub.dev/documentation/rad/latest/widgets_html/Citation-class.html)
, [Data](https://pub.dev/documentation/rad/latest/widgets_html/Data-class.html)
, [DataList](https://pub.dev/documentation/rad/latest/widgets_html/DataList-class.html)
, [Definition](https://pub.dev/documentation/rad/latest/widgets_html/Definition-class.html)
, [DeletedText](https://pub.dev/documentation/rad/latest/widgets_html/DeletedText-class.html)
, [DescriptionDetails](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionDetails-class.html)
, [DescriptionList](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionList-class.html)
, [DescriptionTerm](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionTerm-class.html)
, [Details](https://pub.dev/documentation/rad/latest/widgets_html/Details-class.html)
, [Dialog](https://pub.dev/documentation/rad/latest/widgets_html/Dialog-class.html)
, [Division](https://pub.dev/documentation/rad/latest/widgets_html/Division-class.html)
, [EmbedExternal](https://pub.dev/documentation/rad/latest/widgets_html/EmbedExternal-class.html)
, [EmbedTextTrack](https://pub.dev/documentation/rad/latest/widgets_html/EmbedTextTrack-class.html)
, [Emphasis](https://pub.dev/documentation/rad/latest/widgets_html/Emphasis-class.html)
, [FieldSet](https://pub.dev/documentation/rad/latest/widgets_html/FieldSet-class.html)
, [Figure](https://pub.dev/documentation/rad/latest/widgets_html/Figure-class.html)
, [FigureCaption](https://pub.dev/documentation/rad/latest/widgets_html/FigureCaption-class.html)
, [Footer](https://pub.dev/documentation/rad/latest/widgets_html/Footer-class.html)
, [Form](https://pub.dev/documentation/rad/latest/widgets_html/Form-class.html)
, [Header](https://pub.dev/documentation/rad/latest/widgets_html/Header-class.html)
, [Heading1](https://pub.dev/documentation/rad/latest/widgets_html/Heading1-class.html)
, [Heading2](https://pub.dev/documentation/rad/latest/widgets_html/Heading2-class.html)
, [Heading3](https://pub.dev/documentation/rad/latest/widgets_html/Heading3-class.html)
, [Heading4](https://pub.dev/documentation/rad/latest/widgets_html/Heading4-class.html)
, [Heading5](https://pub.dev/documentation/rad/latest/widgets_html/Heading5-class.html)
, [Heading6](https://pub.dev/documentation/rad/latest/widgets_html/Heading6-class.html)
, [HorizontalRule](https://pub.dev/documentation/rad/latest/widgets_html/HorizontalRule-class.html)
, [Idiomatic](https://pub.dev/documentation/rad/latest/widgets_html/Idiomatic-class.html)
, [IFrame](https://pub.dev/documentation/rad/latest/widgets_html/IFrame-class.html)
, [Image](https://pub.dev/documentation/rad/latest/widgets_html/Image-class.html)
, [ImageMap](https://pub.dev/documentation/rad/latest/widgets_html/ImageMap-class.html)
, [ImageMapArea](https://pub.dev/documentation/rad/latest/widgets_html/ImageMapArea-class.html)
, [InlineCode](https://pub.dev/documentation/rad/latest/widgets_html/InlineCode-class.html)
, [InlineQuotation](https://pub.dev/documentation/rad/latest/widgets_html/InlineQuotation-class.html)
, [Input](https://pub.dev/documentation/rad/latest/widgets_html/Input-class.html)
, [InsertedText](https://pub.dev/documentation/rad/latest/widgets_html/InsertedText-class.html)
, [KeyboardInput](https://pub.dev/documentation/rad/latest/widgets_html/KeyboardInput-class.html)
, [Label](https://pub.dev/documentation/rad/latest/widgets_html/Label-class.html)
, [Legend](https://pub.dev/documentation/rad/latest/widgets_html/Legend-class.html)
, [LineBreak](https://pub.dev/documentation/rad/latest/widgets_html/LineBreak-class.html)
, [LineBreakOpportunity](https://pub.dev/documentation/rad/latest/widgets_html/LineBreakOpportunity-class.html)
, [ListItem](https://pub.dev/documentation/rad/latest/widgets_html/ListItem-class.html)
, [MarkText](https://pub.dev/documentation/rad/latest/widgets_html/MarkText-class.html)
, [MediaSource](https://pub.dev/documentation/rad/latest/widgets_html/MediaSource-class.html)
, [Menu](https://pub.dev/documentation/rad/latest/widgets_html/Menu-class.html)
, [Meter](https://pub.dev/documentation/rad/latest/widgets_html/Meter-class.html)
, [Navigation](https://pub.dev/documentation/rad/latest/widgets_html/Navigation-class.html)
, [Option](https://pub.dev/documentation/rad/latest/widgets_html/Option-class.html)
, [OptionGroup](https://pub.dev/documentation/rad/latest/widgets_html/OptionGroup-class.html)
, [OrderedList](https://pub.dev/documentation/rad/latest/widgets_html/OrderedList-class.html)
, [Output](https://pub.dev/documentation/rad/latest/widgets_html/Output-class.html)
, [Paragraph](https://pub.dev/documentation/rad/latest/widgets_html/Paragraph-class.html)
, [Picture](https://pub.dev/documentation/rad/latest/widgets_html/Picture-class.html)
, [Portal](https://pub.dev/documentation/rad/latest/widgets_html/Portal-class.html)
, [PreformattedText](https://pub.dev/documentation/rad/latest/widgets_html/PreformattedText-class.html)
, [Progress](https://pub.dev/documentation/rad/latest/widgets_html/Progress-class.html)
, [RubyAnnotation](https://pub.dev/documentation/rad/latest/widgets_html/RubyAnnotation-class.html)
, [RubyFallbackParenthesis](https://pub.dev/documentation/rad/latest/widgets_html/RubyFallbackParenthesis-class.html)
, [RubyText](https://pub.dev/documentation/rad/latest/widgets_html/RubyText-class.html)
, [SampleOutput](https://pub.dev/documentation/rad/latest/widgets_html/SampleOutput-class.html)
, [Section](https://pub.dev/documentation/rad/latest/widgets_html/Section-class.html)
, [Select](https://pub.dev/documentation/rad/latest/widgets_html/Select-class.html)
, [Small](https://pub.dev/documentation/rad/latest/widgets_html/Small-class.html)
, [Span](https://pub.dev/documentation/rad/latest/widgets_html/Span-class.html)
, [StrikeThrough](https://pub.dev/documentation/rad/latest/widgets_html/StrikeThrough-class.html)
, [Strong](https://pub.dev/documentation/rad/latest/widgets_html/Strong-class.html)
, [SubScript](https://pub.dev/documentation/rad/latest/widgets_html/SubScript-class.html)
, [Summary](https://pub.dev/documentation/rad/latest/widgets_html/Summary-class.html)
, [SuperScript](https://pub.dev/documentation/rad/latest/widgets_html/SuperScript-class.html)
, [Table](https://pub.dev/documentation/rad/latest/widgets_html/Table-class.html)
, [TableBody](https://pub.dev/documentation/rad/latest/widgets_html/TableBody-class.html)
, [TableCaption](https://pub.dev/documentation/rad/latest/widgets_html/TableCaption-class.html)
, [TableColumn](https://pub.dev/documentation/rad/latest/widgets_html/TableColumn-class.html)
, [TableColumnGroup](https://pub.dev/documentation/rad/latest/widgets_html/TableColumnGroup-class.html)
, [TableDataCell](https://pub.dev/documentation/rad/latest/widgets_html/TableDataCell-class.html)
, [TableFoot](https://pub.dev/documentation/rad/latest/widgets_html/TableFoot-class.html)
, [TableHead](https://pub.dev/documentation/rad/latest/widgets_html/TableHead-class.html)
, [TableHeaderCell](https://pub.dev/documentation/rad/latest/widgets_html/TableHeaderCell-class.html)
, [TableRow](https://pub.dev/documentation/rad/latest/widgets_html/TableRow-class.html)
, [TextArea](https://pub.dev/documentation/rad/latest/widgets_html/TextArea-class.html)
, [Time](https://pub.dev/documentation/rad/latest/widgets_html/Time-class.html)
, [UnOrderedList](https://pub.dev/documentation/rad/latest/widgets_html/UnOrderedList-class.html)
, [Variable](https://pub.dev/documentation/rad/latest/widgets_html/Variable-class.html)
, [Video](https://pub.dev/documentation/rad/latest/widgets_html/Video-class.html)

## Contributing

For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.
