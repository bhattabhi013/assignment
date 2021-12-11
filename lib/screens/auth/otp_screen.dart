import 'dart:convert';
import 'package:whatsub/components/custom_error_dialog.dart';
import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/screens/auth/user_info.dart';
import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _agreeToTerms = false;
  String otpEntered = "";
  bool _isLoading = false;
  TextEditingController _otpController = TextEditingController();

  // @override
  // void initState() {
  // super.initState();
  // try {
  //   _getOTP();
  // } catch (e) {}
  // }

  // void _getOTP() async {
  //   String msg = await AndroidSmsRetriever.requestOneTimeConsentSms();
  //   AndroidSmsRetriever.stopSmsListener();
  //   if (msg.substring(msg.length - 5) == 'Dash.') {
  //     otpEntered = msg.substring(30, 36);
  //     _otpController.text = otpEntered;
  //     _agreeToTerms = true;
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;

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
                    "cheemde has sent you an otp",
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
                    "enter the 6 digit otp sent on ${widget.phoneNumber} to proceed",
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
                      controller: _otpController,
                      autofocus: true,
                      maxLength: 6,
                      onChanged: (val) {
                        if (val.length >= 6) {
                          _agreeToTerms = true;
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        } else {
                          _agreeToTerms = false;
                        }
                        otpEntered = val;
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                          counterText: '',
                          hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                          hintText: 'OTP',
                          border: InputBorder.none),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: screenHeight * 0.07,
                    child: NeuButton(
                      isActive: _agreeToTerms,
                      isLoading: _isLoading,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_agreeToTerms == true && otpEntered.length == 6) {
                          var response = await http.post(
                              Uri.parse('https://auth.grow90.org/phone/verify_otp'),
                              headers: {
                                'App_id':
                                    'e344caf7-831a-4298-b4bd-c835fbff9be7',
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode({
                                "phone": widget.phoneNumber,
                                "otp": otpEntered
                              }));

                          var decodedRes = json.decode(response.body);
                          if (decodedRes['type'] == 'success') {
                            setState(() {
                              _isLoading = false;
                            });
                            SharedPreferences _prefs =
                                await SharedPreferences.getInstance();
                            _prefs.setString(PrefsConstants.authToken,
                                decodedRes['auth_token']);
                            _prefs.setString(
                                PrefsConstants.userID, decodedRes['id']);
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => UserInfo()));
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            showCustomErrorDialog(context, "Failure",
                                decodedRes['error'] + ". Please try again.");
                          }
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          showCustomErrorDialog(context, "Validation error",
                              "Please agree to terms & conditions. Also make sure that you've entered valid OTP at your number ${widget.phoneNumber}");
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
                      ),
                    ),
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
