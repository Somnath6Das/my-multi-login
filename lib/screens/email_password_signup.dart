import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth_methods.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EmailPasswordSignup extends StatefulWidget {
  // static String routeName = '/signup-email-password';
  const EmailPasswordSignup({super.key});

  @override
  State<EmailPasswordSignup> createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    FireBaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(email: emailController.text.trim(), password: passwordController.text.trim(), context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Signup with email and password',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              keyboardType: TextInputType.emailAddress,
                controller: emailController, hintText: 'Email address'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              keyboardType: TextInputType.text,
                controller: passwordController, hintText: 'Password'),
          ),
          CustomButton(text: 'Register', onTap: signUpUser, color: Colors.green)
        ],
      ),
    );
  }
}
