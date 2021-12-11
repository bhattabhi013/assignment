import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:whatsub/components/custom_error_dialog.dart';
import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/screens/auth/otp_screen.dart';
import 'package:whatsub/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:http/http.dart' as http;

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  Apis api = Apis();
  bool _agreeToTerms = false;
  bool _isLoading = false;
  TextEditingController _mobileController = TextEditingController();
  // bool _autoValidate = false;
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPass = false;

  bool checkDone = false;

  @override
  void initState() {
    super.initState();
    _getPhoneNumber();
  }

  void _getPhoneNumber() async {
    String phoneNumber = await AndroidSmsRetriever.requestPhoneNumber();
    _mobileController.text = phoneNumber.substring(phoneNumber.length - 10);
  }

  // var spinkit = SpinKitRipple(
  //   color: Colors.green[800],
  //   size: 100.0,
  // );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight - MediaQuery.of(context).padding.top,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ).copyWith(top: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "cheemde needs your number to verify that its you",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "give cheemde your number",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      maxLength: 10,
                      onChanged: (value) async {
                        if (value.length >= 10) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        }
                      },
                      controller: _mobileController,
                      autofocus: true,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: '',
                          hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                          hintText: '9876543210',
                          border: InputBorder.none),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: screenWidth * 0.07,
                    height: screenWidth * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Theme(
                      data:
                          ThemeData(unselectedWidgetColor: Colors.transparent),
                      child: Checkbox(
                        value: _agreeToTerms,
                        activeColor: Colors.transparent,
                        checkColor: Colors.white,
                        onChanged: (bool? newVal) {
                          setState(() {
                            _agreeToTerms = newVal!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "i have read all terms and conditions also i agree to all. i agree to all the terms and conditions.",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: screenHeight * 0.07,
                    child: NeuButton(
                        isLoading: _isLoading,
                        isActive: _agreeToTerms,
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_agreeToTerms == true) {
                            var response = await http.post(
                                Uri.parse('https://auth.grow90.org/phone/register_without_password'),
                                headers: {
                                  'App_id':
                                      'e344caf7-831a-4298-b4bd-c835fbff9be7',
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(
                                    {"phone": _mobileController.text}));

                            var decodedRes = json.decode(response.body);

                            log("Decoded Res : " + decodedRes.toString());
                            if (decodedRes['type'] == 'success') {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => OTPScreen(
                                        phoneNumber: _mobileController.text,
                                      )));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              showCustomErrorDialog(context, "", "");
                            }
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            showCustomErrorDialog(
                                context,
                                "Terms & Conditions.",
                                "Please agree to terms & conditions.");
                          }
                        },
                        child: Center(
                          child: Text(
                            "continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
