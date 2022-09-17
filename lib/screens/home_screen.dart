import 'package:flutter/material.dart';
import 'package:my_multiple_login/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<FireBaseAuthMethods>().user;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(user.email != null) Text(user.email!),
          if (user.phoneNumber == null) Text(user.email!),
          if (user.phoneNumber == null) Text(user.providerData[0].providerId),
          if (user.phoneNumber != null) Text(user.phoneNumber!),
          Text(user.uid),
          if (!user.emailVerified)
            CustomButton(
                text: "Verify Email",
                onTap: () {
                  context
                      .read<FireBaseAuthMethods>()
                      .sendEmailVerification(context);
                },
                color: Colors.black),
          CustomButton(
              text: 'Sign out',
              onTap: () {
                context.read<FireBaseAuthMethods>().signOut(context);
              },
              color: Colors.redAccent),
          CustomButton(
              text: 'Delete',
              onTap: () {
                context.read<FireBaseAuthMethods>().deleteAccount(context);
              },
              color: Colors.red)
        ],
      ),
    ));
  }
}
