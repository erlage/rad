## Navigation

- tests/**generated** - Tests that are generated by scripts.
- tests/**included** - Tests that are borrowed from Flutter SDK.
- tests/**framework** - Core's widget building/updating tests (using `rad_test` pkg).
- tests/**framework-hc** - Core's widget building/updating tests (hard-coded).
- tests/**patched** - Test cases of discovered issues.
- tests/**services** - Various services's tests.
- tests/**hooks** - Tests related to hooks.
- tests/**widgets** - Widget's specific tests.
- tests/**misc** - Some miscellaneous tests.

## Run tests
Run `dart test` in package directory to run all tests.

## Generate tests
Run `py scripts/main.py gen` to re-generate tests(`test/generated`).
