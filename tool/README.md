# Tool: pkg-gen-html-widgets

This script allows generating a custom version of HTML widgets.

## Basic usage

Run `py gen.py` to generate a package.

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
    --name=my_new_package \
    --className:retype=set  \
    --className:rename=classes

cd out
dart pub get
dart format .
```
