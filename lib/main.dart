import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:my_multiple_login/firebase_options.dart';
import 'package:my_multiple_login/screens/home_screen.dart';
import 'package:my_multiple_login/screens/login_screen.dart';
import 'package:my_multiple_login/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await FacebookAuth.i.webInitialize(
        appId: "788123785672078", cookie: true, xfbml: true, version: "v13.0");
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FireBaseAuthMethods>(
            create: (_) => FireBaseAuthMethods(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<FireBaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
        // routes: {
        //   EmailPasswordSignup.routeName: (context) => const EmailPasswordSignup(),
        //   EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
        //   PhoneScreen.routeName: (context) => const PhoneScreen(),
        // }
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
