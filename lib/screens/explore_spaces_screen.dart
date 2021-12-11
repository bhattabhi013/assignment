import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/components/neu_lead_button.dart';
import 'package:whatsub/models/SpacesModel.dart';
// import 'package:whatsub/screens/space_screen.dart';
import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExploreSpaceScreen extends StatefulWidget {
  @override
  _ExploreSpaceScreenState createState() => _ExploreSpaceScreenState();
}

class _ExploreSpaceScreenState extends State<ExploreSpaceScreen>
    with TickerProviderStateMixin {
  List<String> _tabList = ["spaces", "your spaces"];
  late TabController _tabController;
  late String _fullName = "Joey Dash";
  late String _emailID = "joeydash@grow90.org";

  @override
  void initState() {
    super.initState();
    // _tabController =
    //     TabController(length: _tabList.length, vsync: this, initialIndex: 0);
    _getPrefData();
  }

  void _getPrefData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _emailID = _prefs.getString(PrefsConstants.emailID)!;
    _fullName = _prefs.getString(PrefsConstants.fullName)!;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double screenWidth = MediaQuery.of(context).size.width;
 
    return Scaffold(
        backgroundColor: Color.fromRGBO(27, 27, 27, 1.0),
        // drawer: Drawer(
        //   child: Column(
        //     children: [
        //       UserAccountsDrawerHeader(
        //         accountName: Text(_fullName),
        //         accountEmail: Text(_emailID),
        //         currentAccountPicture: ClipOval(
        //           child: Image.asset('assets/images/logo.png'),
        //         ),
        //       ),
        //       ListTile(
        //         onTap: () async {
        //           SharedPreferences _prefs =
        //               await SharedPreferences.getInstance();
        //           _prefs.clear();
        //           Phoenix.rebirth(context);
        //         },
        //         title: Text(
        //           "Log out",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         tileColor: Colors.black12,
        //         dense: true,
        //         trailing: Icon(
        //           Icons.arrow_forward_ios_outlined,
        //           color: Colors.white,
        //           size: 18.0,
        //         ),
        //       ),
        //       Expanded(
        //         child: Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 "dogespace",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 32.0,
        //                     fontWeight: FontWeight.w600),
        //               ),
        //               SizedBox(
        //                 height: 4.0,
        //               ),
        //               Text(
        //                 "<under-devlopment/>",
        //                 style: TextStyle(
        //                     color: Colors.white70,
        //                     fontSize: 10.0,
        //                     fontWeight: FontWeight.w600),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        appBar: AppBar(
            backgroundColor: AppColors.backGroundBlack,
            title: Text(
              'explore spaces',
              style: TextStyle(color: AppColors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                    width: AppBar().preferredSize.height - 6.0 * 2,
                    child: NeuButton(
                        border: 2.0,
                        onPressed: () {},
                        child: Center(child: Icon(Icons.search)))),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelColor: AppColors.white,
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: AppColors.lightGrey,
                  isScrollable: true,
                  labelStyle:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  controller: _tabController,
                  tabs: _tabList
                      .map((e) => SizedBox(
                          height: screenHeight * 0.05,
                          child: Center(child: Text(e))))
                      .toList(),
                ),
              ),
            )),
        body: TabBarView(
          controller: _tabController,
          children: [
            SpacesCard(
              constants: HomeConstants.SPACES,
            ),
            SpacesCard(
              constants: HomeConstants.MYSPACES,
            )
          ],
        ));
  }
}

class SpacesCard extends StatefulWidget {
  const SpacesCard({
    required this.constants,
  });

  final HomeConstants constants;

  @override
  _SpacesCardState createState() => _SpacesCardState();
}

class _SpacesCardState extends State<SpacesCard> {
  @override
  void initState() {
    super.initState();
    _getData(widget.constants);
  }

  Future<SpacesModel> _getData(HomeConstants constants) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _authToken = _prefs.getString(PrefsConstants.authToken)==null?"":_prefs.getString(PrefsConstants.authToken);
    String? _userID = _prefs.getString(PrefsConstants.userID)==null?"":_prefs.getString(PrefsConstants.userID);

    http.Response? response;

    switch (constants) {
      case HomeConstants.SPACES:
        // log("A:"+_authToken);
        // log("U:"+_userID);
        response = await http.post(
            Uri.parse(APIConstants.grow90_base_url+'/api/rest/v2/get_unjoined_spaces'),
            headers: {"Authorization": "Bearer $_authToken", "Content-Type": "application/json"},
            body: jsonEncode({"type": "grow90_track", "user_id": _userID}));
        break;
      case HomeConstants.MYSPACES:
        response = await http.post(
            Uri.parse(APIConstants.db_base_url+'/api/rest/v2/get_my_spaces'),
            headers: {"Authorization": "Bearer $_authToken", "Content-Type": "application/json"},
            body: jsonEncode({"type": "grow90_track", "user_id": _userID}));
        break;
      default:
        response = null;
    }

    SpacesModel _spacesModel;
    if (response != "") {
      _spacesModel = SpacesModel.fromJson(jsonDecode(response!.body));
    } else {
      return SpacesModel(track: []);
    }
    // log(response.body.toString());

    return _spacesModel;
  }

  @override
  Widget build(BuildContext context) {
    log("built");
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey[900],
      child: FutureBuilder(
        future: _getData(widget.constants),
        builder: (BuildContext context, AsyncSnapshot<SpacesModel> snapshot) {
          if (snapshot.hasData == false)
            return Container(
              constraints: BoxConstraints.expand(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/doge_1.png',
                      width: screenWidth * 0.4,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "no spaces found",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: AppBar().preferredSize.height * 2,
                    )
                  ],
                ),
              ),
            );
          return ListView.builder(
              itemCount: snapshot.data!.track!.length,
              padding: EdgeInsets.only(bottom: screenHeight * 0.2),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                Track _thisTrack = snapshot.data!.track![index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22.0)
                      .copyWith(top: 12.0),
                  height: screenHeight * 0.16,
                  // color: Colors.black45,
                  child: ClayContainer(
                    emboss: true,
                    color: Colors.grey[900],
                    curveType: CurveType.none,
                    parentColor: Colors.grey[900],
                    spread: 4,
                    depth: 20,
                    borderRadius: 10,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenHeight * 0.015),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              imageUrl: _thisTrack.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error_outline_outlined),
                              height: screenHeight * 0.16 - 22.0,
                              width: screenHeight * 0.16 - 22.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(screenHeight * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _thisTrack.title,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${_thisTrack.trackRegistrationsAggregate.aggregate!.count} travellors',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.lightGrey),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  height: screenHeight * 0.06,
                                  width: double.maxFinite,
                                  child: NeuLeadButton(
                                    onPressed: () async {

                                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                                      String? _authToken = _prefs.getString(PrefsConstants.authToken);
                                      String? _userID = _prefs.getString(PrefsConstants.userID);
                                      http.Response response;
                                      response = await http.post(
                                          Uri.parse(APIConstants.db_base_url+'/api/rest/v2/join_spaces'),
                                          headers: {"Authorization": "Bearer $_authToken"},
                                          body: jsonEncode({"track_id": _thisTrack.id, "user_id": _userID}));

                                      var data = json.decode(response.body);
                                      // log(data.toString());
                                      _prefs.setString(AppConstants.spaceID, _thisTrack.id);
                                      _prefs.setString(AppConstants.spaceName, _thisTrack.title);
                                      Phoenix.rebirth(context);
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (_) => SpaceScreen()));
                                    },
                                    border: 6.0,
                                    color: Colors.indigo,
                                    child: Text(
                                      'join now',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    icon: Icon(
                                      Icons.bolt,
                                      color: Colors.yellow[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
