# Adaptive widgets

A Flutter package for for building adaptive widgets. 
Supports Android, iOS, Linux, macOS and Windows.
all methods are supported on all platforms.

## Usage

To use this package, add `adaptive_widgets` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Example
```dart
Size screenSize = MediaQuery.of(context).size;

AdaptiveWidget.isSmallScreen(screenSize); // Return true when is Small screen size

AdaptiveWidget.isMediumScreen(screenSize); // Return true when is Medium screen size

AdaptiveWidget.isLargeScreen(screenSize); // Return true when is Large screen size

AdaptiveWidget(largeScreenPage(), mediumScreenPage(), smallScreenPage()); // Verify the screen size and return a corresponding LayoutBuilder widget page
```

## Supported platforms

Methods support by platform:

| Methods | Android | iOS | Linux | macOS | Windows |
| :--- | :---: | :---: | :---: | :---: | :---: |
| isSmallScreen | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |
| isMediumScreen | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |
| isLargeScreen | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |
| AdaptiveWidget | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |

## Additional information

Future plans to develop a library of responsive and adaptive UI Kit