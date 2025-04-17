# School App

A Flutter application that provides lessons for students.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Run](#run)
- [Build](#build)
- [Features](#features)
- [Usage](#usage)
- [Folder Structure](#folder-structure)

## Features

- Auth
- splash
- [Onboarding](#onboarding)
- Lessons
- Theme
- [Localization](#localization)
- [State Management](#state-management)
- [Routing](#routing)
- [API Integration](#api-integration)
- [Log](#log)
- [Storage](#storage)


## Prerequisites

Make sure you have the following installed:

- Flutter (version 3.27.4)
- Dart SDK
- Android Studio / VS Code


## Installation

This project uses [FVM (Flutter Version Management)](https://fvm.app/) to manage the Flutter SDK version.

1. Clone the repository:

```bash
git clone https://github.com/Ramahu/flutter_internship.git
cd flutter_internship
```

2. Make sure you have FVM installed:

```bash
dart pub global activate fvm
```
Install the required Flutter SDK version:
```bash
fvm install 3.27.4
```
Get the project dependencies:
```bash
flutter pub get 
```
You can also run Flutter commands using fvm flutter instead of flutter.

3. Recommended Extensions:

This project includes a `.vscode/extensions.json` file that suggests helpful VS Code extensions for development.  
To install them:

1. Open the project in [Visual Studio Code](https://code.visualstudio.com/)
2. When prompted, click **"Install All"** to install the recommended extensions
3. Or open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run:

```bash
Extensions: Show Recommended Extensions (Workspace)
```

## Run

To run the project locally, use the following command:

```bash
flutter run
```
Ensure you have a device/emulator connected and the Flutter environment properly set up.

## Build

You can build the project for different platforms using Flutter and FVM.

### Common Build Commands

```bash
# Build for Android
fvm flutter build apk --release

# Build for iOS (on macOS)
fvm flutter build ios --release
```

## Usage


### Routing

The app uses [`go_router`](https://pub.dev/packages/go_router) for navigation management.

#### How to Add a New Route

1. Define the Route Path :

All route paths are defined in `core/router/app_routes.dart`
To add a new route, define a new static constant in the `AppRoutes` class
```dart
  static const String home = '/home';
```
2. Register the Route in the routes list:

Routes are registered in core/router/app_router.dart using GoRoute
```dart
GoRoute(
  path: AppRoutes.home,
  builder: (context, state) => const HomeScreen(),
),
```
3. Navigate to the Route :
```dart
// Using the path
// go
context.go( AppRoutes.home);
// OR push
context.push(AppRoutes.lessons);
```
Or use named navigation if defined.

4. Add Conditional Redirects (Optional) :

Redirect logic can be applied in the router configuration

```dart
redirect: (context, state) {
  final authValue = isAuth.value;
  final loggedIn = authValue.value ?? false;

  if (loggedIn && state.fullPath == AppRoutes.login) {
    return AppRoutes.home;
  }

  return null;
},

```

#### Summary

| Path               | Screen           | Requires Auth |
|--------------------|------------------|---------------|
| `/splash`          | SplashScreen     | ❌            |
| `/onboarding`      | OnboardingScreen | ❌            |
| `/login`           | LoginScreen      | ❌            |
| `/home`            | HomeScreen       | ✅            |
| `/lessons`         | LessonsScreen    | ✅            |

### State Management

The app uses [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod)  with `StateNotifier` is used.
-Each feature has its own provider and notifier.


#### How to Add a New Notifier

To add a new `Notifier`, follow these steps:

1. Create the Provider Folder :

Inside your feature directory, create a `provider` folder `features/your_feature/provider/`


2. Add a New Dart File :

Create a new Dart file (e.g., `auth_provider.dart`) in the `provider` folder

```dart
// lib/features/auth/provider/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

3. Create the Notifier Class:

Create a StateNotifier class that will manage the state. This class should extend StateNotifier<AsyncValue<-->>, where AsyncValue<--> represents the loading, success, or error state of the process.
```dart
class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthNotifier() : super(const AsyncValue.loading());
}
```
4. Add Function:

Inside the Notifier class, define a function that handles the logic (e.g., login, fetchData, etc).
The state is updated to reflect loading, success, or error based on the result.
You can call your request class inside this function to make the API call.
```dart
  Future<void> login() async {
    state = const AsyncValue.loading(); // Set loading state
    try {
      final authRequests = AuthRequests(); // Replace with your request class
      final success = await authRequests.login(); // Sample login logic

      if (success) {
        state = const AsyncValue.data(true); // Update state to success
      } else {
        state = const AsyncValue.data(false); // Update state to failure
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st); // Handle error and set error state
    }
  }
```

5. Define the Provider:

Finally, define a StateNotifierProvider to expose the Notifier to the rest of the app. This provider can be accessed in your UI code to manage state.
```dart
final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<bool>>((ref) {
  return AuthNotifier();
});
```

6. Call Notifier Functions :

In Riverpod, `ref` is a reference object passed to your providers and widgets that gives you access to other providers and utilities like `read`, `watch`, and `listen`.

| Method             | Description                                           | Rebuilds Widget | Recommended Usage                  |
|--------------------|-------------------------------------------------------|------------------|-------------------------------------|
| `ref.watch()`      | Subscribes to the provider and rebuilds on changes   | ✅               | Inside `build()` methods            |
| `ref.read()`       | Reads the provider once without listening             | ❌               | Inside callbacks or one-time usage |
| `ref.listen()`     | Listens to provider changes to perform side effects   | ❌               | Inside `initState()` or logic code |
| `ref.invalidate()` | Invalidates the provider and forces refresh           | ❌               | On logout or to refresh manually   |


### API Integration

This project uses `ApiClient` class (located at `lib/core/network/remote/api_client.dart`) to handle all HTTP requests using the [`Dio`](https://pub.dev/packages/dio).

#### How to Add a New API Requests

1. Create a Service File :

- Inside your feature folder (e.g., `features/auth`), create a `service/` folder if it doesn't already exist.
- Inside `service/`, create a Dart file (e.g., `auth_requests.dart`).

2. create a class : 

In that file, create a class (e.g., `AuthRequests`)  and an instance of `ApiClient` to perform HTTP operations.

```dart
  final ApiClient apiClient = ApiClient();
```

3. Create a method :

inside that class to call one of the base HTTP methods
```dart
  Response response = await apiClient.postRequest(
        endpoint: AppConfigs.login,
        data: data,
      );
```
You can replace postRequest with getRequest, putRequest, or deleteRequest based on the use case.

4. Create a Model :

If the API returns structured data (e.g., user profile, list of lessons), it’s a good practice to create a model class to deserialize the response.

- Create a model/ folder inside your feature directory if it doesn’t exist (e.g., features/auth/model/).

- Inside the model/ folder, create a file like user_model.dart.

- Define a Dart class that maps to the API response.

5. parse the model :

Back in your service class, parse the model after the API call:

```dart
  UserModel user = UserModel.fromJson(response.data);
```

6. Handle Response and Return Result : 

Return a consistent response format from the service method, for example

```dart
  return {
        'success': true,
        'message': response.data['message'],
      };
```

In case of errors, catch the exception and return:

```dart
  return {
  'success': false,
  'message': e.response?.data['message'] ?? 'Something went wrong',
};

```

7. Call the Service from a Notifier :

Inside your Riverpod StateNotifier , import the service class.

- Create an instance of your request class

```dart
  final authRequests = AuthRequests();
```
- Call the function you wrote in the service class:

```dart
final response = await authRequests.login(
  email: email,
  password: password,
);
```
- Handle the returned result:

```dart
if (response['success']) {
  // Success logic 
  state = const AsyncValue.data(true);
} else {
  // Error logic 
  state = const AsyncValue.data(false);
}
```

#### Adding New Interceptors 

If you want to add a new Dio interceptor (e.g., for caching, retry logic), you should add it inside the same file

by extending the `dio.interceptors.addAll([...])` list.

```dart
dio.interceptors.addAll([
      AuthInterceptor(),
      // here
]);
```


### Localization

This project supports **English** and **Arabic** using `.arb` files and the `flutter_localizations` package.

#### How Localization Works

- The app automatically uses the **device's locale** when launched for the first time.
- Users can manually switch languages in the **Settings** screen.
- The selected language is saved locally and persists between app launches.
- We use **Riverpod** for managing and reacting to locale changes.

#### Prerequisite

Make sure you have the **Flutter Intl** extension installed in VSCode for easy management of translation files.

> VSCode Extension: [Flutter Intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)

#### How to Add New Localized Text

To add a new translatable string:

1. Open the localization files:
   - `lib/l10n/intl_en.arb` (for English)
   - `lib/l10n/intl_ar.arb` (for Arabic)

2. Add your new key-value pair to each file. For example:

   ```json
   // intl_en.arb
   {
     "welcome": "Welcome"
   }

   // intl_ar.arb
   {
     "welcome": "مرحبا"
   }


3. Use the generated string in your widgets:

```dart
import 'package:intern/generated/l10n.dart';

Text(AppLocalizations.of(context)!.welcome)
```

### Storage

#### Caching API Responses with Dio Interceptor

This project uses `DioCacheInterceptor` to cache GET API responses like lists for performance improvement and offline support , in `ApiClient` class (located at `lib/core/network/remote/api_client.dart`).

##### Setup (Already Configured)

The interceptor is configured with custom `CacheOptions` :

```dart
final cacheOptions = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.forceCache,
  priority: CachePriority.high,
  maxStale: const Duration(days: 7),
  hitCacheOnErrorCodes: [401, 403, 404, 422],
  cipher: null,
  allowPostMethod: false,
  hitCacheOnNetworkFailure: true,
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
);
```
The _mergeOptions method is used to apply caching based on a bool isCached flag

##### How to Use : 

If you want to cache a GET request:

Pass isCached: true when calling the request 

```dart
final response = await apiClient.getRequest(
  endpoint: AppConfigs.subject,
  isCached: true,
);
```
The response will be stored in memory and served from cache for future identical requests unless expired.

#### Caching with SharedPreferences 

This app also uses `SharedPreferences` to store simple data such as the selected theme or localization settings.

##### Implementation Details

SharedPreferences logic is abstracted inside ( `lib/core/network/local/cache_helper.dart`).
This file contains a CacheHelper class with the saveData , getData, remove methods

##### How to Use SharedPreferences

1. Define the storage key : 

Add your storage key inside 'lib/core/util/storage_keys.dart'

```dart
const String localeKey = 'locale';
```

2. Save data :

To store a value (e.g., save language code)

```dart
await CacheHelper.saveData(key: localeKey, value: code);
```

3. Retrieve data :

To retrieve a value with fallback

```dart
String langCode = CacheHelper.getData(key: localeKey) ?? 'en';
```

3. remove data :

```dart
 CacheHelper.remove(key: localeKey)
```

### Log

This project uses [PrettyDioLogger](https://pub.dev/packages/pretty_dio_logger) to log network requests and responses for debugging purposes.

#### Where it's implemented

Logging is configured inside:

```plaintext
lib/core/network/remote/api_client.dart
```

The following interceptor is added to Dio:

```dart
  PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: true,
    maxWidth: 90,
    enabled: kDebugMode, // Enabled only in debug mode
  ),
```

### Onboarding

To add a new onboarding screen:

1. Navigate to the following file:
lib/features/onboarding/page/onboarding_screen.dart

2. Inside that file, locate the `children` list of onboarding pages inside PageView.

3. Add a new `OnboardingPage` item like this:

```dart
OnboardingPage(
  imagePath: Assets.assetsOnboarding1, // Replace with your asset
  title: AppLocalizations.of(context).yourTitleKey, // Replace with your localized title
  description: AppLocalizations.of(context).yourSubtitleKey, // Replace with your localized subtitle
),
```
Make sure you add your new localized strings to the appropriate .arb files. 

4. Update onPageChanged logic to match the last index:

```dart
onPageChanged: (index) {
  setState(() {
    onLastPage = (index == 2); // Change 2 to your last index (e.g., 3 if you have 4 pages)
  });
},
```

5. Update SmoothPageIndicator to the new page count:

```dart
SmoothPageIndicator(
  controller: _controller,
  count: 3, // Update this count to match the number of onboarding pages
  effect: const WormEffect(
    dotHeight: 12,
    dotWidth: 12,
    activeDotColor: defaultBlue2,
  ),
),
```

6. Update the skip button to jump to the last page:

```dart
TextButton(
  onPressed: () {
    _controller.jumpToPage(2); // Update this index to the last page index
  },
  child: Text(AppLocalizations.of(context).skip),
),
```


### Lessons
- Automatically fetches and paginates online lessons.
- You can:
  - Search by text
  - Filter by subject
  - Scroll to fetch more



## Folder Structure

lib/
├── core/
│   ├── network/
│   ├── router/
│   ├── util/
│   ├── theme_notifier.dart
│   ├── localization_notifier.dart
├── features/
│   ├── auth/
│   ├── lessons/
│   ├── onboarding/
│   ├── splash/
│   ├── settings/
│   └── home_screen.dart
└── main.dart
