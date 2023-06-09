# Talk Stream

Talk Stream is a real-time chat application that allows users to join chat rooms and communicate with other users. This repository contains the source code for the Talk Stream mobile application.

## Features

- Communicate with other users in real-time
- Send private messages to other users
- Receive push notifications for new messages
- View the online/offline status of other users

### Mobile App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

A Very Good Project created by Very Good CLI.

---

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Talk Stream works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Tech Stack

The Talk Stream backend is built using the following technologies:

- [Dart Frog](https://dartfrog.dev/), a backend web framework for the Dart programming language

The Talk Stream mobile app is built using the following technologies:

- [Flutter](https://flutter.dev/), a mobile app development framework
- [Dart Frog Client](https://pub.dev/packages/dart_frog_client), a Dart client library for the Dart Frog framework
- [Flutter WebSocket](https://pub.dev/packages/web_socket_channel), a library for implementing WebSockets in Flutter

## Contributing

We welcome contributions to the Talk Stream project! To get started, please read the [contributing guidelines](CONTRIBUTING.md) and [code of conduct](CODE_OF_CONDUCT.md).

## License

Talk Stream is released under the [MIT License](LICENSE).

---

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
