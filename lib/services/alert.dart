// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import "package:easyclass/shared/constant.dart";

class AlertService {
  BuildContext context;
  String titleofAlret;
  String contentofAlert;

  singleButtonAlert(BuildContext context, String titleofAlret, String contentofAlert) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleofAlret,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(contentofAlert),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('අනුමත කරනවා'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> subscribeToNewClass(BuildContext context) {
    bool wantToaccept;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'නව පන්ති සැකසුම',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ඔබට මෙම පන්තියට දායක වීමට අවශ්‍යද?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'දායක වන්න',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                wantToSignOut = true;
                Navigator.of(context).pop(wantToSignOut);
              },
            ),
            TextButton(
              child: const Text('ඉවතලන්න'),
              onPressed: () async {
                wantToSignOut = false;
                Navigator.of(context).pop(wantToSignOut);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> signOutAlert(BuildContext context) {
    bool wantToSignOut;
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(
            'සැකසීම සඳහා ඇඟවීම',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ඔබට වරනය වීමට අවශ්‍යද?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'වරන්න',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                wantToSignOut = true;
                Navigator.of(context).pop(wantToSignOut);
              },
            ),
            TextButton(
              child: const Text('නැත'),
              onPressed: () async {
                wantToSignOut = false;
                Navigator.of(context).pop(wantToSignOut);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> addMobileNumberAlert(BuildContext context) {
    String selectedCountryCode = '+94';
    final maskFormatter = MaskTextInputFormatter(mask: '(##) ### ####');
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(
            'සැකසීම සඳහා ඇඟවීම',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('කරුණාකර ඔබගේ ජංගම දුරකථන අංකය ඇතුලත් කරන්න'),
                SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: CountryCodePicker(
                        onChanged: (onValue) {
                          selectedCountryCode = onValue.toString();
                        },
                        //selectedCountryCode = onValue;

                        initialSelection: '+94',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        child: Container(
                          width: 120.0,
                          height: 40.0,
                          child: TextField(
                            inputFormatters: [
                              maskFormatter
                            ],
                            decoration: textInputDecoration.copyWith(hintText: '(##) ### ####', contentPadding: EdgeInsets.all(10.0)),
                            keyboardType: TextInputType.number,
                            controller: customController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ඇතුල් කරන්න',
                // style: TextStyle(backgroundColor: Colors.grey),
              ),
              onPressed: () async {
                Navigator.of(context).pop(selectedCountryCode + customController.text.toString());
                //Navigator.of(context).pop(customController.text.trim());
              },
            ),
            TextButton(
              child: const Text('අවලංගු කරන්න'),
              onPressed: () async {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> forgotPassWord(BuildContext context) {
    String selectedCountryCode = '+94';
    final maskFormatter = MaskTextInputFormatter(mask: '(##) ### ####');
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(
            'පුරනය සඳහා ඇඟවීම',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('කරුණාකර ඔබගේ විද්‍යුත් තැපැල් ලිපිනය ඇතුලත් කරන්න'),
                SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        child: Container(
                          // width: 120.0,
                          height: 40.0,
                          child: TextField(
                            decoration: textInputDecoration.copyWith(hintText: 'විද්යුත් තැපැල් ලිපිනය', contentPadding: EdgeInsets.all(10.0)),
                            controller: customController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ඉල්ලීම',
                // style: TextStyle(backgroundColor: Colors.grey),
              ),
              onPressed: () async {
                //Navigator.of(context).pop(selectedCountryCode + customController.text.toString());
                Navigator.of(context).pop(customController.text.trim());
              },
            ),
            TextButton(
              child: const Text('අවලංගු කරන්න'),
              onPressed: () async {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
  }
}
