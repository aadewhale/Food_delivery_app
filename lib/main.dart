import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/provider/user.dart';
import 'package:myapp/screens/Home.dart';
import 'package:myapp/screens/Homepage.dart';

import 'package:myapp/provider/app.dart';
import 'package:myapp/provider/categoryProvider.dart';
import 'package:myapp/provider/product.dart';

import 'package:myapp/screens/login.dart';
import 'package:myapp/screens/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1)),
          builder: (context, AsyncSnapshot snapshot) {
            // Show splash screen while waiting for app resources to load:
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(home: Splash());
            } else {
              // Loading is done, return the app:
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Food App',
                  theme: ThemeData(
                    primarySwatch: Colors.red,
                  ),
                  home: ScreensController());
            }
          })));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Homepage();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return Homepage();
    }
  }
}
