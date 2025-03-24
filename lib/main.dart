import 'package:bmi/signin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAmUVSIsfNzAXIWKmF4LK3hA7XIPORhWeU", appId: "1:118089107794:web:935a635ca3483f3fbd128b",messagingSenderId: "118089107794", projectId: "bmi-app-e38ce"),);
  }

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        drawer: Drawer(), // Add your Drawer widget here
        body: const SignInScreen(),
      ),
    );
  }
}