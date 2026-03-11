.PHONY: get build run clean icons splash l10n

get:
	flutter pub get

build:
	dart run build_runner build --delete-conflicting-outputs

run: get build
	flutter run

clean:
	flutter clean
	flutter pub get

icons:
	dart run flutter_launcher_icons

splash:
	dart run flutter_native_splash:create

l10n:
	flutter gen-l10n
