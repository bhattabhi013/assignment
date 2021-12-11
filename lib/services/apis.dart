import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Apis {
  String mainUrl = "https://db.grow90.org/v1/graphql";

  String regUrl = 'https://auth.grow90.org/phone/register_without_password';
  String urlVerify = "https://auth.grow90.org/phone/verify_otp";

  String phone = "";
  String id = "";
  String name = "";

  // String mapApiKey = "AIzaSyAFlIBg-s63Qn-cf4Gd3ix7mRJXVCd_T5A";

  Map<String, String> mainRequestHeaders = {
    'App_id': 'e344caf7-831a-4298-b4bd-c835fbff9be7',
    'Content-Type': 'application/json',
  };

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  Apis() {
    initialize();
  }

  initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('stringValue')==null?"":prefs.getString('stringValue');
    if (stringValue != null) {
      Map temp = json.decode(stringValue);
      mainRequestHeaders['Authorization'] = "Bearer " + temp["key"];
      // print(mainRequestHeaders['Authorization']);
      phone = temp["mobile"];
      var payload =
          '{"query":"query MyQuery {\\n  auth {\\n    id\\n    fullname\\n  }\\n}\\n","variables":null,"operationName":"MyQuery"}';
      var response =
          await http.post(Uri.parse(mainUrl), body: payload, headers: mainRequestHeaders);
//    print('Response status: ${response.statusCode}');
      Map parsed = json.decode(response.body);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print("PArsed");
      print(parsed);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  addName(String phone, String name) async {
    var payload =
        '{"query":"mutation MyMutation {\\n  update_auth(where: {phone: {_eq: \\"$phone\\"}}, _set: {fullname: \\"$name\\"}) {\\n    affected_rows\\n  }\\n}\\n","variables":null,"operationName":"MyMutation"}';
    var response =
        await http.post(Uri.parse(mainUrl), body: payload, headers: mainRequestHeaders);
//    print('Response status: ${response.statusCode}');
    Map parsed = json.decode(response.body);
    print(parsed);
  }

  registerApi(String payload) async {
    var response =
        await http.post(Uri.parse(regUrl), body: payload, headers: requestHeaders);
//    print('Response status: ${response.statusCode}');
    Map parsed = json.decode(response.body);
    return parsed;
  }

  verifyOtp(String payload) async {
    var response =
        await http.post(Uri.parse(urlVerify), body: payload, headers: requestHeaders);
    Map parsed = json.decode(response.body);
    return parsed;
  }
}
