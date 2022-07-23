# Contributing

Thank you for your interest in contributing to Rad!

## Project philosophy

Before getting to the issues and pull requests, it is important to understand what the framework is trying to do.

Rad's stated goal is really simple - create a frontend framework, that is great for building web apps. 

- The most important thing here is building a framework that also **works very well**, and that should always be the top priority.

- We take the **stability** and **performance** seriously. Updates are thoroughly reviewed for [performance impacts](https://github.com/erlage/rad-benchmarks) before being released, and we have a [comprehensive test suite](https://github.com/erlage/rad/tree/main/packages/rad/test). Ideally, that means no performance issues and just consistently good execution. 

## Opening Issues

While opening issue, please keep in mind following things:

- One issue per bug. Putting multiple things in the same issue makes both discussion and completion unnecessarily complicated.
- When raising an issue, please be as thorough as possible. For possible bugs, reproducible code is always a great sign.
- Feature requests are welcome. However, please make sure that the feature you are requesting falls under the scope of the project.

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

    dart format $(find . -name "*.dart" -not -path "*/templates/*" -not -path '*/.*')
    ```

**Avoid**:

- Making big pull requests as they are difficult to review.
- Fixing multiple issues in a single pull request(deliberately).

**Don't**:

- Include commented-out code.
- Add any dependency to framework.
- Attempt large architectural changes.
- Submit code that's incompatible with the framework licence.
- Touch anything outside the stated scope of the pull request.

### What are some things you can work on?

- Anything from pending [bugs](https://github.com/erlage/rad/labels/bug), [enhancements](https://github.com/erlage/rad/labels/enhancement), [feature requests](https://github.com/erlage/rad/labels/feature).
- Anything that fixes something in existing code.
- Anything that improves or add something to existing documentation/readme(s).
- Anything that add/improve tests.

If you want to work on something that's not in opened issues, just open an issue for it! and wait for someone to add label to your issue. Please do not take this the wrong way. This lets us avoid working on the same thing, or worse, someone putting in a lot of work for a pull request that does not fit into the scope of the project.

## License
Any contribution you make will fall under the license being used by the framework.
