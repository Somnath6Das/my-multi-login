import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_multiple_login/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class PhoneScreen extends StatefulWidget {
  // static String routeName = '/phone';

  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Signup with phone',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: phoneController,
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomButton(text: 'Get OTP', onTap: phoneSignIn, color: Colors.green)
        ],
      ),
    );
  }

  void phoneSignIn() {
    context
        .read<FireBaseAuthMethods>()
        .phoneSignIn(context, "+91${phoneController.text.trim()}");

    // FireBaseAuthMethods(FirebaseAuth.instance)
    //     .phoneSignIn(context, "+91${phoneController.text.trim()}");
  }
}
