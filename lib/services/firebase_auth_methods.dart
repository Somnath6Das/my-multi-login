import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/show_otp_dialog.dart';
import '../utils/show_snackBar.dart';

class FireBaseAuthMethods {
  final FirebaseAuth _auth;
  FireBaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  // state persistence
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  //options:
  //FirebaseAuth.instance.userChanges();
  //FirebaseAuth.instance.idTokenChanges();

  // Email Sign up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'You gave a weak password!');
      }

      showSnackBar(context, e.message!);
    }
  }

  //Email login.
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //sent Email for verification
  Future<void> sendEmailVerification(
    BuildContext context,
  ) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Verification sent to your given mail address!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

// sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _auth.signInWithPopup(googleProvider);
      } else {
        //facing error on this section
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser != null) {
          try {
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            UserCredential userCredential =
                await _auth.signInWithCredential(credential);
          } on FirebaseAuthException catch (e) {
            showSnackBar(context, e.message!);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

// Facebook login
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

//phone sign in
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();

    if (kIsWeb) {
      // Works on only on web
      ConfirmationResult result =
          await _auth.signInWithPhoneNumber(phoneNumber);
      showOTPDialog(
        codeController: codeController,
        context: context,
        onPressed: () async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: result.verificationId,
              smsCode: codeController.text.trim());
          await _auth.signInWithCredential(credential);
          Navigator.of(context).pop();
        },
      );
    } else {
      // Works on android
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showSnackBar(context, e.message!);
          },
          codeSent: ((String verificationId, int? resendToken) async {
            showOTPDialog(
              codeController: codeController,
              context: context,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim());
                await _auth.signInWithCredential(credential);
                Navigator.of(context).pop();
              },
            );
          }),
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 30));
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
