import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_multiple_login/firebase_options.dart';
import 'package:my_multiple_login/screens/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      // routes: {
      //   EmailPasswordSignup.routeName: (context) => const EmailPasswordSignup(),
      //   EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
      //   PhoneScreen.routeName: (context) => const PhoneScreen(),
      // }
    );
  }
}
