import 'package:cookbook1/firebase_options.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:cookbook1/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().themedata,
      home: FirebaseAuth.instance.currentUser != null
          ? const Home()
          : LoginPage(),
    );
  }
}
