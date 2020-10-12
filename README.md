# Images App

Image gallery application that uses [pixabay](https://pixabay.com/) image source implementation and has capabilities to scale as needed with different image providers.


## Demo Videos (Youtube Link)


> Normal Grid Tiles

[![Images App Demo - Normal Grids](https://img.youtube.com/vi/8LanmvkhMNE/0.jpg)](https://youtu.be/8LanmvkhMNE)


> Staggered Grid Tiles

[![Images App Demo - Staggered Grids](https://img.youtube.com/vi/LOkaxv36CC8/0.jpg)](https://youtu.be/LOkaxv36CC8)

## Try APK 

Test APK on Android devices without any development configurations

[APK](https://drive.google.com/file/d/1falA1SAUqWstW0P-u6l5C8yCL1ptGzGs/view?usp=sharing)

[Fix: Unknown Sources](https://www.applivery.com/docs/troubleshooting/android-unknown-sources/)


## Architecture / State Management

[BLoC (Business Logic Component) design pattern](https://bloclibrary.dev/#/whybloc)


## Dependencies


- [dio](https://pub.dev/packages/dio) 
> A powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.


- [provider](https://pub.dev/packages/provider)
> A wrapper around InheritedWidget to make them easier to use and more reusable.


- [flutter_bloc](https://pub.dev/packages/flutter_bloc) 
> Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.


- [equatable](https://pub.dev/packages/equatable)
> An abstract class that helps to implement equality without needing to explicitly override == and hashCode.


- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
> Easily configure any flutter application with global variables using a `.env` file.


- [shared_preferences](https://pub.dev/packages/shared_preferences)
> Flutter plugin for reading and writing simple key-value pairs. Wraps NSUserDefaults on iOS and SharedPreferences on Android.


- [cached_network_image](https://pub.dev/packages/cached_network_image)
> Flutter library to load and cache network images. Can also be used with placeholder and error widgets.


- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)
> A Flutter staggered grid view (masonry tiles) which supports multiple columns with rows of varying sizes


- [photo_view](https://pub.dev/packages/photo_view)
> Photo View provides a gesture sensitive zoomable widget. Photo View is largely used to show interacive images and other stuff such as SVG.


- [fimber](https://pub.dev/packages/fimber)
> Extensible logging for Flutter - based on Timber on Andoird, using similar (as far as Dart lang allows) method API with same concepts for tree and planting logging tree.


- [sentry](https://pub.dev/packages/sentry)
> A crash reporting library for for Dart that sends crash reports to Sentry.io. This library supports Dart VM, and Flutter for mobile, web, and desktop.


- [package_info](https://pub.dev/packages/package_info)
> Flutter plugin for querying information about the application package, such as CFBundleVersion on iOS or versionCode on Android.



## Environment variables

We are using the `.env` file from the root of the project for environment configurations

Below are environment variables we are using


* Base URL for pixabay image source
>>
BASE_URL=https://pixabay.com/

* API Key obtained from [pixabay](https://pixabay.com/api/docs/)
>>
API_KEY={YOUR_API_KEY}

* Load images per page `(default: 20)`
>>
ITEMS_PER_PAGE=20

* Max suggestions to show `(default: 10)`
>>
MAX_SUGGESTIONS_TO_SHOW=10

* Types of grid tile `(default: normal)`<br/>
mark this `true` to use staggered grid tiles
>>
GRID_TILE_STAGGERED=false

* Crash reporting service configurations from [sentry.io](https://sentry.io/)
>> 
SENTRY_DSN={YOUR_SENTRY_DSN_URL}


## Tree

> Top Level (Project)
```
.
├── README.md
├── android
├── images_app.iml
├── ios
├── lib
├── pubspec.lock
├── pubspec.yaml
└── test
```

> Flutter Code - Level 2 (./lib)

```
.
├── app
│   ├── crash_reporting_tree.dart
│   ├── images_app.dart
│   ├── index.dart
│   └── simple_bloc_observer.dart
├── domain
│   ├── data
│   ├── index.dart
│   ├── models
│   └── repos
├── infrastructure
│   ├── data
│   ├── index.dart
│   ├── pixabay
│   └── repos
├── main.dart
└── ui
    ├── images
    ├── index.dart
    ├── search
    ├── swiper
    └── widgets
```

> Flutter Code - Detailed (./lib)

```
.
├── app
│   ├── crash_reporting_tree.dart
│   ├── images_app.dart
│   ├── index.dart
│   └── simple_bloc_observer.dart
├── domain
│   ├── data
│   │   ├── index.dart
│   │   └── key_value_store.dart
│   ├── index.dart
│   ├── models
│   │   ├── app_image.dart
│   │   └── index.dart
│   └── repos
│       ├── images_repo.dart
│       ├── index.dart
│       └── suggestions_repo.dart
├── infrastructure
│   ├── data
│   │   ├── index.dart
│   │   └── shared_pref_kv_store.dart
│   ├── index.dart
│   ├── pixabay
│   │   ├── index.dart
│   │   ├── pixabay_image.dart
│   │   ├── pixabay_image_parser.dart
│   │   └── pixaby_images_repo.dart
│   └── repos
│       ├── index.dart
│       └── suggestions_repo.dart
├── main.dart
└── ui
    ├── images
    │   ├── bloc
    │   │   ├── images_bloc.dart
    │   │   ├── images_event.dart
    │   │   └── images_state.dart
    │   ├── images.dart
    │   └── view
    │       ├── images_body_builder.dart
    │       ├── images_grid_view.dart
    │       ├── images_page.dart
    │       ├── index.dart
    │       ├── no_images_result.dart
    │       └── search_button.dart
    ├── index.dart
    ├── search
    │   ├── bloc
    │   │   ├── suggestions_bloc.dart
    │   │   ├── suggestions_event.dart
    │   │   └── suggestions_state.dart
    │   ├── search.dart
    │   └── view
    │       ├── app_search_delegate.dart
    │       ├── images_results.dart
    │       ├── index.dart
    │       ├── suggestions_no_results.dart
    │       └── suggestions_results.dart
    ├── swiper
    │   ├── swiper.dart
    │   └── view
    │       ├── image_swiper.dart
    │       ├── images_page_view.dart
    │       ├── index.dart
    │       └── interactive_image_view.dart
    └── widgets
        ├── index.dart
        └── search.dart
```


## Run App

To run the app with debug mode

`git clone GIT_REMOTE_URL`

`cd YOUR_CLONED_APP`

`flutter run`



## Deployment

[Build and release an Android app](https://flutter.dev/docs/deployment/android)


[Build and release an iOS app](https://flutter.dev/docs/deployment/ios)




## Getting Started

This project is a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Installation](https://flutter.dev/docs/get-started/install)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
