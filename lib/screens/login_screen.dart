import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_multiple_login/screens/email_password_login.dart';
import 'package:my_multiple_login/screens/email_password_signup.dart';
import 'package:my_multiple_login/screens/phone_screen.dart';
import 'package:my_multiple_login/services/firebase_auth_methods.dart';
import 'package:my_multiple_login/widgets/custom_button.dart';
import 'package:my_multiple_login/widgets/next_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              CustomButton(
                  text: "Login with email",
                  onTap: () {
                    nextScreen(context, const EmailPasswordLogin());
                  },
                  color: Colors.green),
              const SizedBox(height: 10),
              CustomButton(
                  text: "Signup with Phone",
                  onTap: () {
                    nextScreen(context, const PhoneScreen());
                  },
                  color: Colors.black),
              const SizedBox(height: 10),
              CustomButton(
                  text: "Signup with Google ",
                  onTap: () {
                    context
                        .read<FireBaseAuthMethods>()
                        .signInWithGoogle(context);

                    // FireBaseAuthMethods(FirebaseAuth.instance)
                    //     .signInWithGoogle(context);
                  },
                  color: Colors.red),
              const SizedBox(height: 10),
              CustomButton(
                  text: "Signup with Facebook ",
                  onTap: () {
                    context
                        .read<FireBaseAuthMethods>()
                        .signInWithFacebook(context);

                    // FireBaseAuthMethods(FirebaseAuth.instance)
                    //     .signInWithFacebook(context);
                  },
                  color: Colors.blueAccent),
              const SizedBox(height: 10),
              CustomButton(
                  text: "Signup with Twitter ",
                  onTap: () {
                    nextScreen(context, const EmailPasswordSignup());
                  },
                  color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
