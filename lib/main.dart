/// This file is the main entry point for the Flutter application.
///
/// It imports necessary packages such as `flutter/material.dart` for Material Design widgets,
/// `flutter_bloc/flutter_bloc.dart` for the BLoC (Business Logic Component) pattern,
/// `get/get.dart` for route management and state management,
/// `lenovo_app/bloc/auth_bloc.dart` for the authentication BLoC, and
/// `lenovo_app/screens/splash_screen.dart` for the splash screen of the application.
///
/// The `main` function calls `runApp` with an instance of `MyApp`, which is a custom `StatelessWidget`.
///
/// `MyApp` is a root widget that provides an `AuthBloc` to its descendants using the `BlocProvider`.
/// `AuthBloc` is presumably a part of the BLoC (Business Logic Component) pattern used for state management in this application.
///
/// `MyApp` also sets up the root of the application's widget tree with `GetMaterialApp`, a special version of `MaterialApp` provided by the `get` package.
///
/// The `debugShowCheckedModeBanner` property is set to `false` to remove the debug banner from the UI in debug mode.
///
/// The `home` property is set to `SplashScreen()`, which means the `SplashScreen` widget is the first screen displayed when the app launches.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/bloc/auth_bloc.dart';
import 'package:lenovo_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
