# Flutter App's simplest automated full test

This project shows an example of the main forms of automated testing in Flutter mobile App, being:

- [Unitary][] (including [mocking][] on unitary);
- [Widgets][];
- [Integration][] (or assertion).

Using native libraries or recommended by official Flutter documentation (Google).

> Note that everything here fits within the guidelines set out in [Effective Dart][].

[Unitary]: https://flutter.dev/docs/cookbook/testing/unit/introduction
[mocking]: https://flutter.dev/docs/cookbook/testing/unit/mocking
[Widgets]: https://flutter.dev/docs/cookbook/testing/widget/introduction
[Integration]: https://flutter.dev/docs/cookbook/testing/integration/introduction
[Effective Dart]: https://www.dartlang.org/guides/language/effective-dart

## Prerequisites

You will need [Flutter][] framework 1.9.1+hotfix.6 or above installed.

> The Dart SDK **is not required** because Flutter has _[Dart language][]_ support as an integrated tool in the framework.

[Flutter]: https://flutter.dev/
[Dart language]: https://dart.dev/

**Libraries:**

- [test][] 1.6.3
- [provider][] 3.1.0+1
- [pedantic][] 1.8.0+1 (dev)

[test]: https://pub.dev/packages/test
[provider]: https://pub.dev/packages/provider
[pedantic]: https://pub.dev/packages/pedantic

## Running tests

To test the project, run:

    flutter test

To check test coverage, run:

- Run test with `--coverage` flag:

      flutter test --coverage

- Convert the LCOV report generated to a readable HTML file:

      genhtml coverage/lcov.info -o coverage/html

  > The **`flutter test --coverage`** command will generate a **`lcov.info`** file, you will need to install the **[LCOV][]** program to convert (**`genhtml ...`**) the report to an HTML file (human readable).

- Open the HTML report (with a Web Browser)

      google-chrome coverage/html/index.html

[LCOV]: http://ltp.sourceforge.net/coverage/lcov.php

To test only **Unit tests** of the project, run:

    flutter test test/unit/

To test only **Widget tests** of the project, run:

    flutter test test/widget/

To test only **Integration** (or assertion) of the project, run:

    flutter drive --target=test_driver/app.dart

> "Unlike unit and widget tests, integration test suites do not run in the same process as the app being tested. Therefore, create two files that reside in the same directory. By convention, the directory is named **`test_driver`**."
> \- An introduction to integration testing

## License

Copyright © 2019 | Chinnon Santos | MIT
