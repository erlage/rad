# Rad

Rad is a frontend framework for creating fast and interactive web apps using Dart. It's inspired from Flutter and shares same programming paradigm. It has all the best bits of Flutter(StatefulWidgets, Builders) and allows you to use web technologies(HTML and CSS) in your app.

## Quick links

- [Getting started](https://github.com/erlage/rad/blob/main/doc/getting_started.md)
- [Package @ pub.dev](https://pub.dev/packages/rad)
- [API reference @ pub.dev](https://pub.dev/documentation/rad/latest/rad/rad-library.html)
- [Repository @ github.com](https://github.com/erlage/rad)

## Let's start

Below is a hello world in Rad:

```dart
void main() {
  runApp(
    targetId: 'output',
    app: Text('hello world'),
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
    targetId: 'output',
    app: HomePage(),
  );
}
```
If you're familiar with Flutter it don't even need an explanation. Internally, Rad has some differences that might not be apparent from the examples above so let's discuss them first.

## Differences

1. First off, we don't use a rendering engine to render a widget or anything like that. Widgets are mapped to HTML tags and composed together the way you describe them.

2. Second, you can use use CSS for adding animations without ever thinking about how browsers carries them out.

3. Lastly, for layouts, you've to use HTML. And guess what? there are widgets for that.
  
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

There are two important characteristics of HTML widgets that we'd like to talk about:

### 1. HTML widgets are composable

Just like other widgets, HTML widgets are composable and has same semantics in the sense that they can be composed and mixed together with other widgets. For example,

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
In above example, a Span widget is containing a ListView widget. Further, that ListView is containing a StatefulWidget and a Span widget. The point we're trying to make is that HTML widgets won't restrict you to 'just HTML'. You can mix HTML widgets with other widgets.

### 2. HTML widgets are extendable

Designing and re-using UIs is a common requirement of every project. HTML widgets are flexible enough that you can use them to create your own widgets and re-usable UIs. To give you an example, let's say you want a stack widget. First, create a StackEntry widget:

```dart
class StackEntry extends Division
{
  const StackEntry(Widget widget): super( 
    style: 'position: absolute; top: 0; left: 0;',
    children: [widget],
  );
}
```

Then create a Stack widget:

```dart
class Stack extends Division
{
  const Stack({required List<StackEntry> children}): super( 
    style: 'position: relative;',
    children: children,
  );
}
```
and that's pretty much it. Here's how you can use our newly created Stack widget:
```dart
  Stack(
    children: [
      StackEntry(Text('hellow 1')),
      StackEntry(Text('hellow 2')),
    ]
  )
```
This might not look like a big improvement at first but we've actually created a brand new widget that has its own identity and semantics using existing widget. Unlike other frameworks where you'd create a component by implementing bunch of methods, in Rad you can extend widgets to create new widgets.

## FAQ

> Can we use Rad for creating a static website?

  Yes.

> Can we use Rad for creating a dynamic website?

  Yes, that's something this framework is good at.

> Can we use Rad for creating a single page application/or a web app?

  Yes, that'll be perfect. Rad has widgets with powerful mechanics for dealing with nested routing, deep linking, history and state management.

> Is it SEO friendly?

  Rad is a frontend framework and server side rendering is a must for better SEOs. Some frontend frameworks provides SSR but unfortunately we don't have that at the moment. However you can use a backend technology(PHP, Node, Erlang etc.) to stuff meta information in your root page, based on location that a client requested, before serving the page to client. We assure you that this is a sane, simple, and effective approach.

## Widgets Index

Below is the list of available widgets in this framework.

> Some widgets are named after Flutter widgets because they either works exactly same or can be used to acheive same things but in a differnet way(more or less). All those widgets are marked according to their similarity level.
> 
> Markings:
>   - *exact*: Exact syntax, similar semantics.
>   - *same*: Exact syntax with few exceptions, similar semantics.
>   - *different*: Different syntax, different semantics.
>   - *experimental*: --
>
> Please note that these markings are based solely on my understanding of Flutter widgets/src. If you happen to find any big differences, do let me know.

### Abstract

- [InheritedWidget](https://pub.dev/documentation/rad/latest/rad/InheritedWidget-class.html) \[*exact*\]
- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html) \[*exact*\]
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html) \[*exact*\]

### Navigator/Routing

- [Navigator](https://pub.dev/documentation/rad/latest/rad/Navigator-class.html) \[*different*\]
- [Route](https://pub.dev/documentation/rad/latest/rad/Route-class.html) \[*different*\]
- [AsyncRoute](https://pub.dev/documentation/rad/latest/rad/AsyncRoute-class.html) \[*different*\]

### Builders

- [FutureBuilder](https://pub.dev/documentation/rad/latest/rad/FutureBuilder-class.html) \[*exact*\]
- [StreamBuilder](https://pub.dev/documentation/rad/latest/rad/StreamBuilder-class.html) \[*exact*\]
- [ValueListenableBuilder](https://pub.dev/documentation/rad/latest/rad/ValueListenableBuilder-class.html) \[*exact*\]
- [ListView.builder](https://pub.dev/documentation/rad/latest/rad/ListView/ListView.builder.html) \[*same*\]

### Misc

- [RadApp](https://pub.dev/documentation/rad/latest/rad/RadApp-class.html)
- [RawMarkUp](https://pub.dev/documentation/rad/latest/rad/RawMarkUp-class.html)
- [Text](https://pub.dev/documentation/rad/latest/rad/Text-class.html) \[*different*\]
- [ListView](https://pub.dev/documentation/rad/latest/rad/ListView-class.html) \[*same*\]
- [GestureDetector](https://pub.dev/documentation/rad/latest/rad/GestureDetector-class.html) \[*experimental*\]

### HTML Widgets

[Abbreviation](https://pub.dev/documentation/rad/latest/rad/Abbreviation-class.html)
, [Anchor](https://pub.dev/documentation/rad/latest/rad/Anchor-class.html)
, [Article](https://pub.dev/documentation/rad/latest/rad/Article-class.html)
, [Blockquote](https://pub.dev/documentation/rad/latest/rad/Blockquote-class.html)
, [BreakLine](https://pub.dev/documentation/rad/latest/rad/BreakLine-class.html)
, [Button](https://pub.dev/documentation/rad/latest/rad/Button-class.html)
, [Canvas](https://pub.dev/documentation/rad/latest/rad/Canvas-class.html)
, [Caption](https://pub.dev/documentation/rad/latest/rad/Caption-class.html)
, [Code](https://pub.dev/documentation/rad/latest/rad/Code-class.html)
, [Division](https://pub.dev/documentation/rad/latest/rad/Division-class.html)
, [FieldSet](https://pub.dev/documentation/rad/latest/rad/FieldSet-class.html)
, [Footer](https://pub.dev/documentation/rad/latest/rad/Footer-class.html)
, [Form](https://pub.dev/documentation/rad/latest/rad/Form-class.html)
, [Header](https://pub.dev/documentation/rad/latest/rad/Header-class.html)
, [Heading(1-6)](https://pub.dev/documentation/rad/latest/rad/Heading1-class.html)
, [HorizontalRule](https://pub.dev/documentation/rad/latest/rad/HorizontalRule-class.html)
, [IFrame](https://pub.dev/documentation/rad/latest/rad/IFrame-class.html)
, [Idiomatic](https://pub.dev/documentation/rad/latest/rad/Idiomatic-class.html)
, [Image](https://pub.dev/documentation/rad/latest/rad/Image-class.html)
, [InputCheckBox](https://pub.dev/documentation/rad/latest/rad/InputCheckBox-class.html)
, [InputFile](https://pub.dev/documentation/rad/latest/rad/InputFile-class.html)
, [InputRadio](https://pub.dev/documentation/rad/latest/rad/InputRadio-class.html)
, [InputSubmit](https://pub.dev/documentation/rad/latest/rad/InputSubmit-class.html)
, [InputText](https://pub.dev/documentation/rad/latest/rad/InputText-class.html)
, [Label](https://pub.dev/documentation/rad/latest/rad/Label-class.html)
, [Legend](https://pub.dev/documentation/rad/latest/rad/Legend-class.html)
, [ListItem](https://pub.dev/documentation/rad/latest/rad/ListItem-class.html)
, [Menu](https://pub.dev/documentation/rad/latest/rad/Menu-class.html)
, [Navigation](https://pub.dev/documentation/rad/latest/rad/Navigation-class.html)
, [Option](https://pub.dev/documentation/rad/latest/rad/Option-class.html)
, [Paragraph](https://pub.dev/documentation/rad/latest/rad/Paragraph-class.html)
, [Progress](https://pub.dev/documentation/rad/latest/rad/Progress-class.html)
, [Select](https://pub.dev/documentation/rad/latest/rad/Select-class.html)
, [Small](https://pub.dev/documentation/rad/latest/rad/Small-class.html)
, [Span](https://pub.dev/documentation/rad/latest/rad/Span-class.html)
, [StrikeThrough](https://pub.dev/documentation/rad/latest/rad/StrikeThrough-class.html)
, [Strong](https://pub.dev/documentation/rad/latest/rad/Strong-class.html)
, [SubScript](https://pub.dev/documentation/rad/latest/rad/SubScript-class.html)
, [SuperScript](https://pub.dev/documentation/rad/latest/rad/SuperScript-class.html)
, [Table](https://pub.dev/documentation/rad/latest/rad/Table-class.html)
, [TableColumn](https://pub.dev/documentation/rad/latest/rad/TableColumn-class.html)
, [TableColumnGroup](https://pub.dev/documentation/rad/latest/rad/TableColumnGroup-class.html)
, [TableDataCell](https://pub.dev/documentation/rad/latest/rad/TableDataCell-class.html)
, [TableFoot](https://pub.dev/documentation/rad/latest/rad/TableFoot-class.html)
, [TableHead](https://pub.dev/documentation/rad/latest/rad/TableHead-class.html)
, [TableHeaderCell](https://pub.dev/documentation/rad/latest/rad/TableHeaderCell-class.html)
, [TableRow](https://pub.dev/documentation/rad/latest/rad/TableRow-class.html)
, [TextArea](https://pub.dev/documentation/rad/latest/rad/TextArea-class.html)
, [UnOrderedList](https://pub.dev/documentation/rad/latest/rad/UnOrderedList-class.html)

## Why Dart?

I actually tried writing [this in TypeScript before](https://github.com/erlage/proton-framework). While we can do awesome things with types in TS, it also inherits craziness from JS (has to bind 'this', use arrow fun, and more things like that). Later I decided to give Dart a try and I quickly realized that Dart is a very underrated language. You don't have to trust me on that. I had wrote a lot of Dart code with Flutter, but the fact that I choosed TS at first place really shows how underrated Dart actually is. I deeply believe Dart is a amazing language, and I am thankful to all the people who helped create Dart and/or contributing to it, one way or the other.

## Contributing
For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.