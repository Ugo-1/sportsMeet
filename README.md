# SportsMeet
A flutter app to record, network and find like-minded sports interested people. Firebase storage, authentication and database were used to store, retrieve and authenticate user.

## Running the App
To run the app, you should fetch all dependencies and run the build_runner
```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the UI, domain and data layers with a feature-first approach for folder structure, implementing the MVVM architectural pattern.

#### Folder Structure

```
lib
├── core
│   ├── app
│   ├── models
│   ├── services
│   ├── shareable_widgets
│   └── utils
├── features
│   ├── authentication
│   │   ├── view_model
│   │   ├── widgets   
│   │   └── view
│   ├── buddies
│   │   └── view
│   ├── discover
│   │   └── view
│   ├── landing
│   │   ├── view_model
│   │   └── view
│   ├── profile
│   │   ├── view_model
│   │   ├── widgets   
│   │   └── view
│   ├── settings
│   │   ├── widgets   
│   │   └── view
│   └── splash
│       ├── splash_view
│       └── widget_tree
└── main.dart
```

* `main.dart` has the root `MaterialApp` and all necessary configurations and route settings to start the app
* The `core` folder contains code shared across features
    * `app` contains the code generator for Stacked app, implementations and services.
    * `models` contains dart classes/models
    * `services`
    * `shareable_widgets` contains widgets shared within the app
    * `utils` for colors and size management with [Flutter screen utils](https://pub.dev/packages/flutter_screenutil)


* The `features` folder: contains the core features of the app like:
    * `authentication`
    * `buddies`
    * `discover`
    * `landing`
    * `profile`
    * `settings`
    * `splash`

## Third party packages

- [Stacked and its services](https://pub.dev/packages/stacked): Used to implement a very clean MVVM architectural pattern,
  state management and navigation service very cleaner.
- [Firebase auth](https://pub.dev/packages/firebase_auth): Used to enable authentication using password and email, phone number.
- [Firebase core](https://pub.dev/packages/firebase_core): Enabling connecting to multiple Firebase apps.
- [Cloud firestore](https://pub.dev/packages/cloud_firestore): A cloud hosted no-SQL database
- [Firebase storage](https://pub.dev/packages/firebase_storage): A storage service
- [Flutter screen utils](https://pub.dev/packages/flutter_screenutil): For adapting to different screen and font sizes to look good on different mobile screens.
- [Modal progress hud nsn](https://pub.dev/packages/modal_progress_hud_nsn): To enable modal progress indicator
- [Flutter chips input](https://pub.dev/packages/flutter_chips_input):  For building input fields with InputChips as input options.
- [Pinput](https://pub.dev/packages/pinput): Pin code input field.
- [International phone field](https://pub.dev/packages/intl_phone_field): Used to create a text field that retrieves phone number and country code.
- [Cached network image](https://pub.dev/packages/cached_network_image): To retrieve images from the internet and keep them in the cache directory also creates a placeholder. 
- [Image picker](https://pub.dev/packages/image_picker): To obtain an image from the user.
- [Permission handler](https://pub.dev/packages/permission_handler): Used to request and check permission.
