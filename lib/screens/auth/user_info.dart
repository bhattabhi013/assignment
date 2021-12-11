import 'dart:convert';
// import 'dart:developer';

import 'package:whatsub/components/custom_error_dialog.dart';
import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  // const UserInfo({ });

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _agreeToTerms = true;
  String fullNameEntered = "";
  String emailEntered = "";
  bool _isloading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _authToken = _prefs.getString(PrefsConstants.authToken)==null?"":_prefs.getString(PrefsConstants.authToken);
    String? _userID = _prefs.getString(PrefsConstants.userID)==null?"":_prefs.getString(PrefsConstants.userID);
    http.Response response;
    response = await http.post(
        Uri.parse(APIConstants.db_base_url + '/api/rest/v2/get_user_data'),
        headers: {"Authorization": "Bearer $_authToken"},
        body: jsonEncode({"id": _userID}));

    var data = json.decode(response.body);
    if (data['auth'] != null && data['auth'].length >= 1) {
      emailEntered =
          data['auth'][0]['email'] == null ? "" : data['auth'][0]['email'];
      fullNameEntered = data['auth'][0]['fullname'] == null
          ? ""
          : data['auth'][0]['fullname'];
      _emailController.text = emailEntered;
      _fullnameController.text = fullNameEntered;
    }
  }

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
                    "cheemde needs your name and email id",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Text(
                    "please enter you full name",
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
                      onChanged: (val) {
                        fullNameEntered = val;
                      },
                      controller: _fullnameController,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      // inputFormatters: <TextInputFormatter>[
                      //   LengthLimitingTextInputFormatter(6),
                      // ],
                      decoration: InputDecoration(
                          // counterText: '',
                          hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                          hintText: 'john doge',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "please enter your email id",
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
                      onChanged: (val) {
                        emailEntered = val;
                      },
                      controller: _emailController,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      // inputFormatters: <TextInputFormatter>[
                      //   LengthLimitingTextInputFormatter(6),
                      // ],
                      decoration: InputDecoration(
                          // counterText: '',
                          hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                          hintText: 'johndoge@email.com',
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
                      isLoading: _isloading,
                      onPressed: () async {
                        setState(() {
                          _isloading = true;
                        });
                        if (_agreeToTerms == true) {
                          SharedPreferences _prefs =
                              await SharedPreferences.getInstance();
                          String? _authToken =
                              _prefs.getString(PrefsConstants.authToken)==null?"":_prefs.getString(PrefsConstants.authToken);
                          String? _userID =
                              _prefs.getString(PrefsConstants.userID)==null?"":_prefs.getString(PrefsConstants.userID);
                          http.Response response;
                          response = await http.post(
                              Uri.parse(
                                  'https://db.grow90.org/api/rest/v2/set_user_data'),
                              headers: {"Authorization": "Bearer $_authToken"},
                              body: jsonEncode({
                                "fullname": fullNameEntered,
                                "email": emailEntered,
                                "id": _userID
                              }));
                          var decodedRes = json.decode(response.body);
                          if (decodedRes['update_auth']['affected_rows'] >= 1) {
                            _prefs.setString(
                                PrefsConstants.emailID, emailEntered);
                            _prefs.setString(
                                PrefsConstants.fullName, fullNameEntered);
                            setState(() {
                              _isloading = false;
                            });
                            Phoenix.rebirth(context);
                          } else {
                            setState(() {
                              _isloading = false;
                            });
                            showCustomErrorDialog(context, "Failure",
                                decodedRes['error'] + ". Please try again.");
                          }
                        } else {
                          setState(() {
                            _isloading = false;
                          });
                          showCustomErrorDialog(context, "Validation error",
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
