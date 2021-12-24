import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SmsService {
  Future<bool> phoneNumberVerification(String phone, BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final _codeController = TextEditingController();
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) {
          Navigator.of(context).pop();
          print('Auto verified phone number');
        },
        verificationFailed: (AuthException) {
          print('Not verified phone number');
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Give the code?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Confirm'),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                        Navigator.of(context).pop(credential);
                      },
                    ),
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }
}
