rm -rf android/app/build
rm -rf build

flutter clean

flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs