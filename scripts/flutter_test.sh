set -e # abort CI if an error happens
flutter packages get
flutter format --set-exit-if-changed lib test test_driver
flutter analyze --no-current-package lib test/
flutter test --no-pub --coverage
