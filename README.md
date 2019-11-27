# Flutter App's simplest automated full test

[![Codemagic build status](https://api.codemagic.io/apps/5ddbe31c011bc93c37050c9f/5ddbe31c011bc93c37050c9e/status_badge.svg)](https://codemagic.io/apps/5ddbe31c011bc93c37050c9f/5ddbe31c011bc93c37050c9e/latest_build) [![Flutter version](https://img.shields.io/badge/flutter-v1.9.1+hotfix.6-blue?logo=flutter)](https://flutter.dev/docs/get-started/install) [![GitHub license](https://img.shields.io/github/license/chinnonsantos/full_testing_flutter)](https://choosealicense.com/licenses/mit/) [![Twitter follow](https://img.shields.io/twitter/follow/chinnonsantos?label=follow&style=flat&logo=twitter)](https://twitter.com/intent/follow?screen_name=chinnonsantos) [![Slack channel](https://img.shields.io/badge/slack-%23geral-blueviolet?logo=slack)](https://join.slack.com/t/chinnonsantos-nudemo/signup) [![Open source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

This project shows an example of the main forms of automated testing in Flutter mobile App, including integration into a [CI/CD platform][], as follows:

- [Unitary][] (including [mocking][] on unitary);
- [Widgets][];
- [Integration][] (or assertion).

Using native libraries or recommended by official Flutter documentation (Google).

> Note that everything here fits within the guidelines set out in [Effective Dart][].

[CI/CD platform]: https://en.wikipedia.org/wiki/CI/CD
[Unitary]: https://flutter.dev/docs/cookbook/testing/unit/introduction
[mocking]: https://flutter.dev/docs/cookbook/testing/unit/mocking
[Widgets]: https://flutter.dev/docs/cookbook/testing/widget/introduction
[Integration]: https://flutter.dev/docs/cookbook/testing/integration/introduction
[Effective Dart]: https://www.dartlang.org/guides/language/effective-dart

## Codemagic - CI for Flutter

At the [Flutter Live][] 2018 conference in London, [Nevercode][] launched their dedicated CI/CD solution for Flutter apps which is known as [Codemagic][].

This project uses **Codemagic for CI/CD**, selected after various analysis and testing with other CI platforms ([Travis CI][], [Codecov][], [Coveralls][]...), which support the Dart language (in some cases only Dart < 2.0), but do not have good support for the Flutter App.

> "Codemagic is the official CI/CD solution dedicated just for Flutter apps."
> \- Getting Started with Codemagic

See more details about Codemagic in '[Getting Started with Codemagic]'.

[Flutter Live]: https://developers.google.com/events/flutter-live/
[Nevercode]: https://nevercode.io/
[Codemagic]: https://codemagic.io/
[Travis CI]: https://travis-ci.org/
[Codecov]: https://codecov.io/
[Coveralls]: https://coveralls.io/
[Getting Started with Codemagic]: https://blog.codemagic.io/getting-started-with-codemagic/

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

To analyze the Dart language code, run:

    flutter analyze

> The [Dart analyzer][] will check your code and look for possible errors.

[Dart analyzer]: https://flutter.dev/docs/testing/debugging#the-dart-analyzer

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

_-->> First, be sure to launch an Android Emulator, iOS Simulator, or connect your computer to a real iOS / Android device. **Integration testing needs to be executed on a real system (simulator or device)!**_

> "Unlike unit and widget tests, integration test suites do not run in the same process as the app being tested. Therefore, create two files that reside in the same directory. By convention, the directory is named **`test_driver`**."
> \- An introduction to integration testing

## Drive testing on AWS Device Farm with Sylph

To runs Flutter integration tests on real devices in cloud, use the **Sylph**.

- Install Sylph:

      pub global activate sylph

    > For more details see [Sylph][].

- Configure the [AWS CLI][] credentials:

      $ aws configure
      AWS Access Key ID [None]: YOUR_KEY_ID_HERE
      AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY_HERE
      Default region name [None]: us-west-2
      Default output format [None]: json

    > The AWS Device Farm is only available in Oregon region (**us-west-2**)!

- Run the Sylph:

      sylph

    > Sylph uses the [`sylph.yaml`][] file in this repository to configure and run device on AWS.
    >> By default, it has only two Android devices (Samsung Galaxy S9+ and Samsung Galaxy J7).
    >> Running iOS devices requires an [Apple Developer Certificate] (Team ID), We don't cover this steps!

  ![Screenshot from 2019-11-26 16-36-14](https://user-images.githubusercontent.com/3258293/69670720-47cb2300-1073-11ea-8035-1754d43ae395.png)

[Sylph]: https://github.com/mmcc007/sylph
[AWS CLI]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
[`sylph.yaml`]: https://github.com/chinnonsantos/full_testing_flutter/blob/master/sylph.yaml
[Apple Developer Certificate]: https://developer.apple.com/account/#/membership

## Drive testing on Codemagic CI/CD (using AWS Device Farm and Sylph)

Execute the same process when previous step **"Drive testing on AWS Device Farm with Sylph"**.

When you can run local drive testing with Sylph on AWS Device Farm, see [this article] to learn how to configure Codemagic console to automate the process.

![Screenshot from 2019-11-27 09-53-00](https://user-images.githubusercontent.com/3258293/69724965-d71c1900-10fb-11ea-870b-b6d3aab44e2b.png)

[this article]: https://blog.codemagic.io/flutter-ci-cd-with-codemagic-sylph-aws-device-farm/

## Running the APP

To start the mobile App example, run:

    flutter run

## License

Copyright © 2019 | Chinnon Santos | MIT
