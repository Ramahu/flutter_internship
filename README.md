# School App

A Flutter application that provides lessons for students.

## Table of Contents

- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Run](#-run)
- [Build](#-build)
- [Features](#-features)
- [Usage](#-usage)
- [Folder Structure](#-folder-structure)

## Features

- Auth
- splash
- onboarding
- Lessons
- Theme
- Localization
- State Management
- Routing
- Log
- API calls
- storage


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

### Lessons
- Automatically fetches and paginates online lessons.
- You can:
  - Search by text
  - Filter by subject
  - Scroll to fetch more

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


## Folder Structure

lib/
├── core/
│   ├── network/
│   ├── router/
│   ├── util/
│   ├── theme_notifier.dart
├── features/
│   ├── auth/
│   ├── lessons/
│   ├── onboarding/
│   ├── splash/
│   ├── home_screen.dart
├── main.dart

