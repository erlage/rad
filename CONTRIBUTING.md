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

Nobody is perfect, and sometimes we mess things up. That said, here are some good do(s) & don't(s) to try and stick to:

**Do**:

1. Run pre-commit tasks:
    ```sh
    sh scripts/run_pre_commit_tasks.sh
    ```

2. Run tests:
    ```sh
    sh scripts/run_tests.sh
    ```

**Don't**:

- Include commented-out code.
- Add any dependency to framework.
- Attempt large architectural changes.
- Submit code that's incompatible with the framework license.
- Touch anything outside the stated scope of the pull request.

### What are some things you can work on?

- Anything from pending [bugs](https://github.com/erlage/rad/labels/bug), [enhancements](https://github.com/erlage/rad/labels/enhancement), [feature requests](https://github.com/erlage/rad/labels/feature).
- Anything that adds or improves tests.
- Anything that fixes something in the existing code.
- Anything that improves or adds something to the existing documentation/readme(s).

If you want to work on something that's not in opened issues, just open an issue for it! and wait for someone to add a label to your issue. Please do not take this the wrong way. This lets us avoid working on the same thing, or worse, someone putting in a lot of work for a pull request that does not fit into the scope of the project.

When opening such issues and expressing your intent to work on them, please mention it clearly in the issue description or comments. For example, you can state your intention to work on the issue by saying "I would like to take up this task," "I am planning to work on this issue," or "I might be able to work on this." This helps to prevent others from inadvertently starting work on the same task.

## License
Any contribution you make will fall under the license being used by the framework.
