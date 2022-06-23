# Contributing
When contributing to Rad, make sure that the changes you wish to make are in line with the project direction. If you are not sure about this, open an issue first, so we can discuss it.

## Opening Issues

While opening issue, please keep in mind following things:

- One issue per bug. Putting multiple things in the same issue makes both discussion and completion unnecessarily complicated.
- When raising an issue, please be as thorough as possible. For possible bugs, reproducible code is always a great sign.

## Opening Pull Requests

Nobody is perfect, and sometimes we mess things up. That said, here are some good dos & dont's to try and stick to:

**Do**:

- Add description on what has been fixed/improved/added.
- Before commit:
    ```sh
    # Run build runner with default settings
    dart run build_runner build
    
    # Order imports with default settings
    dart pub run import_sorter:main

    # Format updated files with default settings
    dart format updated_file_1 updated_file_2

    # or

    dart format $(find . -name "*.dart" -not -path "*/templates/*")
    ```

**Avoid**:

- Making big pull requests as they are difficult to review.
- Fixing multiple issues in a single pull request(deliberately).

**Don't**:

- Include commented-out code.
- Add any dependency to framework.
- Attempt large architectural changes.
- Submit code that's incompatible with the framwork licence.
- Touch anything outside the stated scope of the pull request.

### What are some things you can work on?

- Anything from pending [bugs](https://github.com/erlage/rad/labels/bug), [enhancements](https://github.com/erlage/rad/labels/enhancement), [feature requests](https://github.com/erlage/rad/labels/feature).
- Anything that fixes something in existing code.
- Anything that improves or add something to existing documentation/readme(s).
- Anything that add/improve tests.

If you want to work on something that's not in opened issues, just open an issue for it! and wait for someone to add label to your issue. Please do not take this the wrong way. This lets us avoid working on the same thing, or worse, someone putting in a lot of work for a pull request that does not fit into the scope of the project.

## License
Any contribution you make will fall under the license being used by the framework.
