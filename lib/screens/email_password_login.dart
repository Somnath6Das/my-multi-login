import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_multiple_login/services/firebase_auth_methods.dart';
import 'package:my_multiple_login/widgets/custom_button.dart';
import 'package:my_multiple_login/widgets/custom_text_field.dart';
import '../widgets/next_screen.dart';
import 'email_password_signup.dart';

class EmailPasswordLogin extends StatefulWidget {
  // static String routeName = '/login-email-password';
  const EmailPasswordLogin({super.key});

  @override
  State<EmailPasswordLogin> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  loginUser() {
    FireBaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login with email and password',
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomButton(text: 'Login', onTap: loginUser, color: Colors.green),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          CustomButton(
            text: "Signup with email",
            onTap: () {
              nextScreen(context, const EmailPasswordSignup());
            },
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
