import 'package:flutter/cupertino.dart';

class AppColors {
  static final Color backGroundBlack = Color.fromRGBO(27, 27, 27, 1);
  static final Color backGroundGrey = Color.fromRGBO(43, 43, 43, 1);
  static final Color lightGrey = Color.fromRGBO(117, 117, 117, 1);
  static final Color white = Color.fromRGBO(224, 224, 224, 1);
  static final Color brownie = Color.fromRGBO(121, 85, 72, 1);
}
class AppConstants {
  static final String spaceID = 'spaceID';
  static final String spaceName = 'spaceName';
}
class APIConstants {
  static final String auth_base_url = 'https://auth.grow90.org';
  static final String db_base_url = 'https://db.grow90.org';
  static final String grow90_base_url = 'https://grow90.org';
}

class PrefsConstants {
  static final String authToken = 'authToken';
  static final String userID = 'userID';
  static final String emailID = 'emailID';
  static final String fullName = 'fullName';
}

enum HomeConstants { MYSPACES, SPACES }
