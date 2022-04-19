# Contributing
We're happy that you looking to contribute to this project. We don't want to impose any strict guidelines on "how things should be" but since there are people using Rad in production we can't accept anything as it as. Below is the little guide that's intended to answer questions that you might have.

## Opening Issues

- Avoid filing multiple bugs in a single issue.
- Use issues for bugs/feature-request/query.
- When raising an issue, please be as thorough as possible. For possible bugs, reproducible code is always a great sign.

## Opening Pull Requests

Pull requests are welcomed. Following below guidelines will save your time:

### Scope

- Anything that improves or add something to existing documentation.
- Anything from pending [Bugs](https://github.com/erlage/rad/labels/bug)
- Anything from pending [Enhancements](https://github.com/erlage/rad/labels/enhancement)
- Anything from pending [Feature requests](https://github.com/erlage/rad/labels/feature%20request)

If you want to work on something that's not in opened issues, just open an issue for it! and wait for someone to add label to your issue. Please do not take this the wrong way. This lets us avoid working on the same thing, or worse, someone putting in a lot of work for a pull request that does not fit into the scope of the project.

**Do**:

- Add description on what has been fixed/improved/added.
- Format your code(`dart format .`) with default settings (before commit/submit).
- Run build runner(`dart run build_runner build`) with default settings (before commit/submit).

**Avoid**

- Making big pull requests as they are difficult to review.
- Fixing multiple issues in a single pull request(deliberately).

**Don't**:

- Include commented-out code.
- Add any dependency to framework.
- Attempt large architectural changes.
- Submit code that's incompatible with the framwork licence.
- Touch anything outside the stated scope of the pull request.

## License
Any contribution you make will fall under the license being used by the framework.