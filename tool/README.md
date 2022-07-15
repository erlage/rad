# Tool: pkg-gen-html-widgets

This script allows generating a custom version of HTML widgets in a separate package.

## Basic usage

Run `py gen.py` to generate a package with custom HTML widgets.

## Options available:

- `className:retype`: Change type of className.
- `className:rename`: Change name of className attribute to something else.

### Package specific options:

- `name`: Package name
- `description`: Package description
- `repo`: Package repository
- `version`: Package version
- `out`: Name of the output directory

## Example usage:

```sh
py gen.py \
    --name=my_new_package
    --className:retype=set # will change type signature of className from String to Set<String>
    --className:rename=classes # will rename className to classes

cd my_new_package
dart pub get
dart format .
```
