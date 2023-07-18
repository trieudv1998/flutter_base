# flutter_base

A new Flutter project.

## Require
- Flutter: 3.3.9
- Dart SDK: 2.18.5

## Getting Started
`flutter pub get`
`flutter pub run build_runner build --delete-conflicting-outputs`

IOS
`cd ios && pod install`

# Build Android
Run command before build

`flutter pub get`
`flutter pub run intl_utils:generate`
`flutter pub run build_runner build --delete-conflicting-outputs`
`flutter build apk --release --flavor ${schemeName}`


# Build iOS
Run command before build

`flutter pub get`
`flutter pub run build_runner build --delete-conflicting-outputs`
`flutter build ios --release --flavor ${schemeName}`