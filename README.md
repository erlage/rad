# Rad

Rad is a frontend framework for creating fast and interactive web apps using Dart. It's inspired from Flutter and shares same programming paradigm. It has all the best bits of Flutter(StatefulWidgets, Builders) and allows you to use web technologies(HTML and CSS) in your app.

[![Rad(core)](https://github.com/erlage/rad/actions/workflows/rad_core.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/rad_core.yml)
[![Reconciler](https://github.com/erlage/rad/actions/workflows/reconciler.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/reconciler.yml)
[![codecov](https://codecov.io/gh/erlage/rad/branch/main/graph/badge.svg?token=PbTQU0aSDn)](https://codecov.io/gh/erlage/rad)

## Quick links

- [Getting started](https://github.com/erlage/rad/blob/main/doc/getting_started.md)
- [Package @ pub.dev](https://pub.dev/packages/rad)
- [API reference @ pub.dev](https://pub.dev/documentation/rad/latest/rad/rad-library.html)
- [Repository @ github.com](https://github.com/erlage/rad)
- [Benchmarks @ github.com](https://github.com/erlage/rad-benchmarks)

## Let's start

Below is a hello world in Rad:

```dart
void main() {
  runApp(
    app: Text('hello world'),
    appTargetId: 'output',
  );
}
```
Let's see another example,
```dart
class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Text('hello world');
  }
}

void main() {
  runApp(
    app: HomePage(),
    appTargetId: 'output',
  );
}
```
If you're familiar with Flutter it don't even need an explanation. Internally, Rad has some differences that might not be apparent from the examples above so let's discuss them first.

## Differences

1. First off, we don't use a rendering engine to render a widget or anything like that. Widgets are mapped to HTML tags and composed together the way you describe them.

2. Second, you can use use CSS for adding animations without ever thinking about how browsers carries them out.

3. And lastly, for layouts, you've to use HTML. And guess what? there are widgets for that.
  
    Let's take this HTML snippet:
    ```html
    <span class="heading big">
      <strong>
        hellow
      </strong>
    </span>
    ```
    Here's how its equivalent will be written using widgets:
    ```dart
    Span(
      classAttribute: 'heading big',
      children: [
        Strong(innerText: 'hellow'),
      ],
    );
    ```

## Flutter widgets

Following widgets in Rad are inspired from Flutter:

- InheritedWidget, StatelessWidget, StatefulWidget.
- FutureBuilder, StreamBuilder and ValueListenableBuilder.

These widgets has same syntax as their Flutter's counterparts. Not just syntax, they also works exactly same as if they would in Flutter. Which means you don't have to learn anything new to be able to use them.

## HTML widgets

Let's take a look at another markup example:
```html
<div>
  <p>Hey there!</p>
</div>
```
Here's how we'll write this using widgets:
```dart
Division(
  children: [
    Paragraph(innerText: 'Hey there!'),  
  ]
)
```
There's also an alternative syntax for HTML widgets:
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
In above example, a Span widget is containing a ListView widget. Further, that ListView is containing a StatefulWidget and a Span widget. The point we're trying to make is that HTML widgets won't restrict you to 'just HTML'.

## Widgets Index

Below is the list of available widgets in this framework. Some widgets are named after Flutter widgets because they either works exactly same or can be used to acheive same things but in a different way(more or less). All those widgets are tagged according to their similarity level.

Similarity tags:
  - *exact*: Exact syntax, similar semantics.
  - *same*: Exact syntax with few exceptions, similar semantics.
  - *different*: Different syntax, different semantics.
  - *experimental*: --

### Abstract

- [InheritedWidget](https://pub.dev/documentation/rad/latest/rad/InheritedWidget-class.html) \[*exact*\]
- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html) \[*exact*\]
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html) \[*exact*\]

### Navigator/Routing

- [Navigator](https://pub.dev/documentation/rad/latest/rad/Navigator-class.html) \[*different*\]
- [Route](https://pub.dev/documentation/rad/latest/rad/Route-class.html) \[*different*\]
- [AsyncRoute](https://pub.dev/documentation/rad/latest/rad/AsyncRoute-class.html)

### Builders

- [FutureBuilder](https://pub.dev/documentation/rad/latest/widgets_async/FutureBuilder-class.html) \[*exact*\]
- [StreamBuilder](https://pub.dev/documentation/rad/latest/widgets_async/StreamBuilder-class.html) \[*exact*\]
- [ValueListenableBuilder](https://pub.dev/documentation/rad/latest/widgets_async/ValueListenableBuilder-class.html) \[*exact*\]
- [ListView.builder](https://pub.dev/documentation/rad/latest/rad/ListView/ListView.builder.html) \[*same*\]

### Functional

- [RadApp](https://pub.dev/documentation/rad/latest/rad/RadApp-class.html)
- [Text](https://pub.dev/documentation/rad/latest/rad/Text-class.html) \[*different*\]
- [ListView](https://pub.dev/documentation/rad/latest/rad/ListView-class.html) \[*same*\]
- [EventDetector](https://pub.dev/documentation/rad/latest/rad/EventDetector-class.html)

### Misc

- [RawMarkUp](https://pub.dev/documentation/rad/latest/rad/RawMarkUp-class.html)
- [RawEventDetector](https://pub.dev/documentation/rad/latest/rad/RawEventDetector-class.html)
- [GestureDetector](https://pub.dev/documentation/rad/latest/rad/GestureDetector-class.html) \[*experimental*\]

### HTML Widgets

[Abbreviation(`abbr`)](https://pub.dev/documentation/rad/latest/widgets_html/Abbreviation-class.html)
, [Address(`address`)](https://pub.dev/documentation/rad/latest/widgets_html/Address-class.html)
, [Anchor(`a`)](https://pub.dev/documentation/rad/latest/widgets_html/Anchor-class.html)
, [Article(`article`)](https://pub.dev/documentation/rad/latest/widgets_html/Article-class.html)
, [Aside(`aside`)](https://pub.dev/documentation/rad/latest/widgets_html/Aside-class.html)
, [Audio(`audio`)](https://pub.dev/documentation/rad/latest/widgets_html/Audio-class.html)
, [BidirectionalIsolate(`bdi`)](https://pub.dev/documentation/rad/latest/widgets_html/BidirectionalIsolate-class.html)
, [BidirectionalTextOverride(`bdo`)](https://pub.dev/documentation/rad/latest/widgets_html/BidirectionalTextOverride-class.html)
, [BlockQuote(`blockquote`)](https://pub.dev/documentation/rad/latest/widgets_html/BlockQuote-class.html)
, [BreakLine(`br`)](https://pub.dev/documentation/rad/latest/widgets_html/BreakLine-class.html)
, [Button(`button`)](https://pub.dev/documentation/rad/latest/widgets_html/Button-class.html)
, [Canvas(`canvas`)](https://pub.dev/documentation/rad/latest/widgets_html/Canvas-class.html)
, [Caption(`caption`)](https://pub.dev/documentation/rad/latest/widgets_html/Caption-class.html)
, [Citation(`cite`)](https://pub.dev/documentation/rad/latest/widgets_html/Citation-class.html)
, [Code(`code`)](https://pub.dev/documentation/rad/latest/widgets_html/Code-class.html)
, [Data(`data`)](https://pub.dev/documentation/rad/latest/widgets_html/Data-class.html)
, [DataList(`datalist`)](https://pub.dev/documentation/rad/latest/widgets_html/DataList-class.html)
, [Definition(`dfn`)](https://pub.dev/documentation/rad/latest/widgets_html/Definition-class.html)
, [DeletedText(`del`)](https://pub.dev/documentation/rad/latest/widgets_html/DeletedText-class.html)
, [DescriptionDetails(`dd`)](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionDetails-class.html)
, [DescriptionList(`dl`)](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionList-class.html)
, [DescriptionTerm(`dt`)](https://pub.dev/documentation/rad/latest/widgets_html/DescriptionTerm-class.html)
, [Details(`details`)](https://pub.dev/documentation/rad/latest/widgets_html/Details-class.html)
, [Dialog(`dialog`)](https://pub.dev/documentation/rad/latest/widgets_html/Dialog-class.html)
, [Division(`div`)](https://pub.dev/documentation/rad/latest/widgets_html/Division-class.html)
, [EmbedExternal(`embed`)](https://pub.dev/documentation/rad/latest/widgets_html/EmbedExternal-class.html)
, [EmbedTextTrack(`track`)](https://pub.dev/documentation/rad/latest/widgets_html/EmbedTextTrack-class.html)
, [Emphasis(`em`)](https://pub.dev/documentation/rad/latest/widgets_html/Emphasis-class.html)
, [FieldSet(`fieldset`)](https://pub.dev/documentation/rad/latest/widgets_html/FieldSet-class.html)
, [Figure(`figure`)](https://pub.dev/documentation/rad/latest/widgets_html/Figure-class.html)
, [FigureCaption(`figcaption`)](https://pub.dev/documentation/rad/latest/widgets_html/FigureCaption-class.html)
, [Footer(`footer`)](https://pub.dev/documentation/rad/latest/widgets_html/Footer-class.html)
, [Form(`form`)](https://pub.dev/documentation/rad/latest/widgets_html/Form-class.html)
, [Header(`header`)](https://pub.dev/documentation/rad/latest/widgets_html/Header-class.html)
, [Heading1(`h1`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading1-class.html)
, [Heading2(`h2`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading2-class.html)
, [Heading3(`h3`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading3-class.html)
, [Heading4(`h4`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading4-class.html)
, [Heading5(`h5`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading5-class.html)
, [Heading6(`h6`)](https://pub.dev/documentation/rad/latest/widgets_html/Heading6-class.html)
, [HorizontalRule(`hr`)](https://pub.dev/documentation/rad/latest/widgets_html/HorizontalRule-class.html)
, [Idiomatic(`i`)](https://pub.dev/documentation/rad/latest/widgets_html/Idiomatic-class.html)
, [IFrame(`iframe`)](https://pub.dev/documentation/rad/latest/widgets_html/IFrame-class.html)
, [Image(`img`)](https://pub.dev/documentation/rad/latest/widgets_html/Image-class.html)
, [ImageMap(`map`)](https://pub.dev/documentation/rad/latest/widgets_html/ImageMap-class.html)
, [ImageMapArea(`area`)](https://pub.dev/documentation/rad/latest/widgets_html/ImageMapArea-class.html)
, [InlineQuotation(`q`)](https://pub.dev/documentation/rad/latest/widgets_html/InlineQuotation-class.html)
, [Input(`input`)](https://pub.dev/documentation/rad/latest/widgets_html/Input-class.html)
, [InsertedText(`ins`)](https://pub.dev/documentation/rad/latest/widgets_html/InsertedText-class.html)
, [KeyboardInput(`kbd`)](https://pub.dev/documentation/rad/latest/widgets_html/KeyboardInput-class.html)
, [Label(`label`)](https://pub.dev/documentation/rad/latest/widgets_html/Label-class.html)
, [Legend(`legend`)](https://pub.dev/documentation/rad/latest/widgets_html/Legend-class.html)
, [LineBreakOpportunity(`wbr`)](https://pub.dev/documentation/rad/latest/widgets_html/LineBreakOpportunity-class.html)
, [ListItem(`li`)](https://pub.dev/documentation/rad/latest/widgets_html/ListItem-class.html)
, [MarkText(`mark`)](https://pub.dev/documentation/rad/latest/widgets_html/MarkText-class.html)
, [MediaSource(`source`)](https://pub.dev/documentation/rad/latest/widgets_html/MediaSource-class.html)
, [Menu(`menu`)](https://pub.dev/documentation/rad/latest/widgets_html/Menu-class.html)
, [Navigation(`nav`)](https://pub.dev/documentation/rad/latest/widgets_html/Navigation-class.html)
, [Option(`option`)](https://pub.dev/documentation/rad/latest/widgets_html/Option-class.html)
, [OptionGroup(`optgroup`)](https://pub.dev/documentation/rad/latest/widgets_html/OptionGroup-class.html)
, [OrderedList(`ol`)](https://pub.dev/documentation/rad/latest/widgets_html/OrderedList-class.html)
, [Output(`output`)](https://pub.dev/documentation/rad/latest/widgets_html/Output-class.html)
, [Paragraph(`p`)](https://pub.dev/documentation/rad/latest/widgets_html/Paragraph-class.html)
, [Picture(`picture`)](https://pub.dev/documentation/rad/latest/widgets_html/Picture-class.html)
, [Portal(`portal`)](https://pub.dev/documentation/rad/latest/widgets_html/Portal-class.html)
, [PreformattedText(`pre`)](https://pub.dev/documentation/rad/latest/widgets_html/PreformattedText-class.html)
, [Progress(`progress`)](https://pub.dev/documentation/rad/latest/widgets_html/Progress-class.html)
, [RubyAnnotation(`ruby`)](https://pub.dev/documentation/rad/latest/widgets_html/RubyAnnotation-class.html)
, [RubyFallbackParenthesis(`rp`)](https://pub.dev/documentation/rad/latest/widgets_html/RubyFallbackParenthesis-class.html)
, [RubyText(`rt`)](https://pub.dev/documentation/rad/latest/widgets_html/RubyText-class.html)
, [SampleOutput(`samp`)](https://pub.dev/documentation/rad/latest/widgets_html/SampleOutput-class.html)
, [Select(`select`)](https://pub.dev/documentation/rad/latest/widgets_html/Select-class.html)
, [Small(`small`)](https://pub.dev/documentation/rad/latest/widgets_html/Small-class.html)
, [Span(`span`)](https://pub.dev/documentation/rad/latest/widgets_html/Span-class.html)
, [StrikeThrough(`s`)](https://pub.dev/documentation/rad/latest/widgets_html/StrikeThrough-class.html)
, [Strong(`strong`)](https://pub.dev/documentation/rad/latest/widgets_html/Strong-class.html)
, [SubScript(`sub`)](https://pub.dev/documentation/rad/latest/widgets_html/SubScript-class.html)
, [Summary(`summary`)](https://pub.dev/documentation/rad/latest/widgets_html/Summary-class.html)
, [SuperScript(`sup`)](https://pub.dev/documentation/rad/latest/widgets_html/SuperScript-class.html)
, [Table(`table`)](https://pub.dev/documentation/rad/latest/widgets_html/Table-class.html)
, [TableBody(`tbody`)](https://pub.dev/documentation/rad/latest/widgets_html/TableBody-class.html)
, [TableColumn(`col`)](https://pub.dev/documentation/rad/latest/widgets_html/TableColumn-class.html)
, [TableColumnGroup(`colgroup`)](https://pub.dev/documentation/rad/latest/widgets_html/TableColumnGroup-class.html)
, [TableDataCell(`td`)](https://pub.dev/documentation/rad/latest/widgets_html/TableDataCell-class.html)
, [TableFoot(`tfoot`)](https://pub.dev/documentation/rad/latest/widgets_html/TableFoot-class.html)
, [TableHead(`thead`)](https://pub.dev/documentation/rad/latest/widgets_html/TableHead-class.html)
, [TableHeaderCell(`th`)](https://pub.dev/documentation/rad/latest/widgets_html/TableHeaderCell-class.html)
, [TableRow(`tr`)](https://pub.dev/documentation/rad/latest/widgets_html/TableRow-class.html)
, [TextArea(`textarea`)](https://pub.dev/documentation/rad/latest/widgets_html/TextArea-class.html)
, [Time(`time`)](https://pub.dev/documentation/rad/latest/widgets_html/Time-class.html)
, [UnOrderedList(`ul`)](https://pub.dev/documentation/rad/latest/widgets_html/UnOrderedList-class.html)
, [Variable(~~`var`~~)](https://pub.dev/documentation/rad/latest/widgets_html/Variable-class.html)
, [Video(`video`)](https://pub.dev/documentation/rad/latest/widgets_html/Video-class.html)

## Contributing
For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.
