import 'package:whatsub/screens/auth/mobile_number_screen.dart';
import 'package:whatsub/screens/auth/user_info.dart';
import 'package:whatsub/screens/explore_spaces_screen.dart';
import 'package:whatsub/screens/space_screen.dart';
import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateWrapperScreen extends StatefulWidget {
  final SharedPreferences preferences;

  const StateWrapperScreen({required this.preferences});

  @override
  _StateWrapperScreenState createState() => _StateWrapperScreenState();
}

class _StateWrapperScreenState extends State<StateWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    String? authToken = widget.preferences.getString(PrefsConstants.authToken)==null?"":widget.preferences.getString(PrefsConstants.authToken);
    String? userID = widget.preferences.getString(PrefsConstants.userID)==null?"":widget.preferences.getString(PrefsConstants.userID);
    String? emailID = widget.preferences.getString(PrefsConstants.emailID)==null?"":widget.preferences.getString(PrefsConstants.emailID);
    String? fullName = widget.preferences.getString(PrefsConstants.fullName)==null?"":widget.preferences.getString(PrefsConstants.fullName);
    String? spaceID = widget.preferences.getString(AppConstants.spaceID)==null?"":widget.preferences.getString(AppConstants.spaceID);

    if (authToken == null)
      return MobileNumberScreen();
    else if (emailID == null)
      return UserInfo();
    else if(spaceID == null)
      return ExploreSpaceScreen();
    else
      return SpaceScreen();
  }
}
