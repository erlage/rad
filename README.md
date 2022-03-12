# Rad

Rad is a frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. In Rad, applications are created using widgets. A widget can describe static as well as dynamic part of user interface. Widgets can be composed together to build more widgets and complex layouts.

## Quick links

- [Getting started](https://github.com/erlage/rad/blob/main/doc/getting_started.md)
- [API reference](https://pub.dev/documentation/rad/latest/rad/rad-library.html)

### Example

Let's take a look at an example written using Rad:

```dart
class HomePage extends StatelessWidget
{
  @override
  build(context) {
    return Text("hello world");
  }
}
```
How about that? if you're familiar with Flutter it don't even need an explanation.

Talking about differences, well there are number of them,

1. First off, we don't use a rendering engine to render a widget or anything like that. Widgets are mapped to HTML tags and composed together they way you describe them. This means every widget has a corresponding HTML tag in DOM, and your application has complete access to document(DOM).

2. To make things manageble, there are widgets for commonly used HTML tags.
  
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
      classAttribute: "heading big",
      children: [
        Strong(innerText: "hellow"),
      ],
    );
    ```
    Note: Since `class` is a reserved word in Dart we're using suffix "Attribute" with it. There are a few more attributes that are reserved, and those can be used with the same suffix "Attribute".

3. Lastly, there are no layout/style specific widgets for example in Flutter we've Container, Stack etc. Just think about it for a sec? we don't really need them as most of things can be done using HTML tags and CSS.

    Just for sake of example, let's say you want a Stack widget,

    1. Create a Stack entry:
        ```dart
        Widget StackEntry(Widget widget)
        {
          return Division( 
              style: "position:absolute;top:0;left:0;",
              children: [widget],
            );

          // Division = HTML's div
        }
        ```
    2. Create a Stack container
        ```dart
        Widget Stack({required List<Widget> children})
        {
          return Division(
              style: "position:relative;",
              children: entries,
            );
        }
        ```
    3. Well done! Here's our newly created Stack widget
        ```dart
        Stack(
          children: [
            StackEntry(Text("hellow 1")),
            StackEntry(Text("hellow 2")),
          ]
        )
        ```
  You can compose widgets the way you want and style them according to your liking.

## Components

Let's make it short. This is a utility that allows dynamic loading of CSS/JS assets.

```dart
App(

  // in your app widget,

  additionalComponents: Components(

    // CSS files (method 1)

    stylesheets: [
      "https://some..css",
      "https://another..css",
      ...
    ],

    // JS files
    
    scripts: [
      "https://some..js",
      "https://another..js",
      ...
    ],

    // CSS (method 2)
    // To be used for external packages.

    styleComponents: [

      SomePackageComponent(),
      
      AnotherPackageComponent(),

    ]
  )
)
```

## Widgets Index

Below is the list of available widgets in this framework.

> Some widgets are named after Flutter widgets because they either works exactly same or can be used to acheive same things but in a differnet way(more or less). All those widgets are marked according to their similarity level.
> 
> Markings:
>   - *exact*: Works exactly same.
>   - *same*: Works nearly the same way.
>   - *differ*: Works different.

### Main

- [App](https://pub.dev/documentation/rad/latest/rad/App-class.html)

### Navigator/Routing

- [Navigator](https://pub.dev/documentation/rad/latest/rad/Navigator-class.html) \[*differ*\]
- [Route](https://pub.dev/documentation/rad/latest/rad/Route-class.html)

### Abstract

- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html) \[*same*\]
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html) \[*same*\]
- [StatelessProvider](https://pub.dev/documentation/rad/latest/rad/StatelessProvider-class.html)

### Builders

- [FutureBuilder](https://pub.dev/documentation/rad/latest/rad/FutureBuilder-class.html) \[*exact*\]
- [StreamBuilder](https://pub.dev/documentation/rad/latest/rad/StreamBuilder-class.html) \[*exact*\]
- [ValueListenableBuilder](https://pub.dev/documentation/rad/latest/rad/ValueListenableBuilder-class.html) \[*exact*\]

### Elements

- [Text](https://pub.dev/documentation/rad/latest/rad/Text-class.html) \[*differ*\]
- [RawMarkUp](https://pub.dev/documentation/rad/latest/rad/RawMarkUp-class.html)
- [GestureDetector](https://pub.dev/documentation/rad/latest/rad/GestureDetector-class.html)

### HTML

- [Header](https://pub.dev/documentation/rad/latest/rad/Header-class.html)
- [Footer](https://pub.dev/documentation/rad/latest/rad/Footer-class.html)
- [Navigation](https://pub.dev/documentation/rad/latest/rad/Navigation-class.html)

- [Span](https://pub.dev/documentation/rad/latest/rad/Span-class.html)
- [Small](https://pub.dev/documentation/rad/latest/rad/Small-class.html)
- [Strong](https://pub.dev/documentation/rad/latest/rad/Strong-class.html)
- [Idiomatic](https://pub.dev/documentation/rad/latest/rad/Idiomatic-class.html)
- [SubScript](https://pub.dev/documentation/rad/latest/rad/SubScript-class.html)
- [SuperScript](https://pub.dev/documentation/rad/latest/rad/SuperScript-class.html)
- [Division](https://pub.dev/documentation/rad/latest/rad/Division-class.html)
- [Anchor](https://pub.dev/documentation/rad/latest/rad/Anchor-class.html)
- [Blockquote](https://pub.dev/documentation/rad/latest/rad/Blockquote-class.html)
- [HorizontalRule](https://pub.dev/documentation/rad/latest/rad/HorizontalRule-class.html)
- [Label](https://pub.dev/documentation/rad/latest/rad/Label-class.html)
- [IFrame](https://pub.dev/documentation/rad/latest/rad/IFrame-class.html)
- [BreakLine](https://pub.dev/documentation/rad/latest/rad/BreakLine-class.html)
- [Image](https://pub.dev/documentation/rad/latest/rad/Image-class.html)
- [Paragraph](https://pub.dev/documentation/rad/latest/rad/Paragraph-class.html)
- [UnOrderedList](https://pub.dev/documentation/rad/latest/rad/UnOrderedList-class.html)
- [ListItem](https://pub.dev/documentation/rad/latest/rad/ListItem-class.html)
- [Button](https://pub.dev/documentation/rad/latest/rad/Button-class.html)
- [Select](https://pub.dev/documentation/rad/latest/rad/Select-class.html)
- [Option](https://pub.dev/documentation/rad/latest/rad/Option-class.html)
- [Progress](https://pub.dev/documentation/rad/latest/rad/Progress-class.html)
- [TextArea](https://pub.dev/documentation/rad/latest/rad/TextArea-class.html)

- [Form](https://pub.dev/documentation/rad/latest/rad/Form-class.html)
- [FieldSet](https://pub.dev/documentation/rad/latest/rad/FieldSet-class.html)
- [Legend](https://pub.dev/documentation/rad/latest/rad/Legend-class.html)
- [InputText](https://pub.dev/documentation/rad/latest/rad/InputText-class.html)
- [InputCheckBox](https://pub.dev/documentation/rad/latest/rad/InputCheckBox-class.html)
- [InputRadio](https://pub.dev/documentation/rad/latest/rad/InputRadio-class.html)
- [InputFile](https://pub.dev/documentation/rad/latest/rad/InputFile-class.html)
- [InputSubmit](https://pub.dev/documentation/rad/latest/rad/InputSubmit-class.html)

- [Heading(1-6)](https://pub.dev/documentation/rad/latest/rad/Heading1-class.html)

## Why Dart?

I actually tried writing [this in TypeScript before](https://github.com/erlage/proton-framework). While we can do awesome things with types in TS, it also inherits craziness from JS (has to bind 'this', use arrow fun, and more things like that). Later I decided to give Dart a try and I quickly realized that Dart is a very underrated language. You don't have to trust me on that. I had wrote a lot of Dart code with Flutter, but the fact that I choosed TS at first place really shows how underrated Dart actually is. I am thankful to all the people who helped create Dart and/or contributing to it, one way or the other.