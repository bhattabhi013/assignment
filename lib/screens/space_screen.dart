import 'dart:math';

import 'package:whatsub/bloc/space_screen_blox.dart';
import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/components/neu_lead_button.dart';
import 'package:whatsub/screens/in_person_chat_screen.dart';
import 'package:whatsub/util/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpaceScreen extends StatefulWidget {
  @override
  _SpaceScreenState createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  int _currentIndex = 0;

  bool _isSearchingInChat = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1200), () => _showDialog());
  }

  @override
  void dispose() {
    BlocProvider.of<SpaceScreenBloc>(context).add(ChangeSpaceScreenState(0));
    super.dispose();
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
             content: buildFlutterTicketWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 10.0,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.backGroundBlack,
              toolbarHeight: screenHeight * 0.07,
              title: (_currentIndex == 0)
                  ? ((!_isSearchingInChat)
                      ? Text(
                          'chats',
                          style: TextStyle(color: AppColors.white),
                        )
                      : AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: screenWidth * 0.6,
                          child: NeumorphicButton(
                            duration: Duration(microseconds: 300),
                            drawSurfaceAboveChild: true,
                            provideHapticFeedback: true,
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.stadium(),
                                intensity: 30.0,
                                depth: -10,
                                surfaceIntensity: 40),
                            padding: EdgeInsets.zero,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                fillColor: AppColors.backGroundGrey,
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ))
                  : (_currentIndex == 1 ? Text('home') : Text('social')),
              actions: [
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: SizedBox(
                      width: screenHeight * 0.07 - 6.0 * 2,
                      child: NeuButton(
                          border: 2.0,
                          onPressed: () {
                            setState(() {
                              _isSearchingInChat = !_isSearchingInChat;
                            });
                          },
                          child: Center(
                              child: Icon(
                            Icons.search,
                            color: Colors.white,
                          )))),
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            floatingActionButton: (_currentIndex == 0)
                ? FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white),
                  )
                : null,
            backgroundColor: AppColors.backGroundGrey,
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                elevation: 10.0,
                onTap: (_newIndex) {
                  setState(() {
                    _currentIndex = _newIndex;
                    BlocProvider.of<SpaceScreenBloc>(context).add(ChangeSpaceScreenState(_newIndex));
                  });
                },
                backgroundColor: AppColors.backGroundBlack,
                unselectedItemColor: Colors.white70,
                selectedItemColor: Color.fromRGBO(121, 85, 72, 1),
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'chat'),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: 'home'),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.globeEurope), label: 'social'),
                ]),
            body: (_currentIndex == 0)
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1 + 16.0),
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0.0,
                        indent: 24.0,
                        endIndent: 24.0,
                        color: Colors.white54,
                      );
                    },
                    itemBuilder: (context, index) {
                      int _msgStatus = Random().nextInt(3) % 3;
                      int _unreadMsgs = Random().nextInt(5);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => InChatScreen(
                                    name: 'Pinak Das',
                                  )));
                        },
                        child: Container(
                          height: screenHeight * 0.1,
                          color: AppColors.backGroundGrey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 16.0),
                                  width: screenHeight * 0.1 - 16.0 * 2,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Pinak Das',
                                          style: TextStyle(
                                              fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                        Text(
                                          '11:39 AM',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          _msgStatus == 0 ? Icons.done_all_rounded : Icons.done,
                                          color: _msgStatus == 0 ? Colors.blue : Colors.white,
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Hi How are you?',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 13.0, fontWeight: FontWeight.w400, color: AppColors.white),
                                          ),
                                        ),
                                        _unreadMsgs == 0
                                            ? SizedBox()
                                            : SizedBox(
                                                width: screenWidth * 0.07,
                                                child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                        color: Colors.blue.shade300,
                                                        shadowLightColor: Colors.grey.shade700,
                                                        intensity: 10),
                                                    child: Center(child: Text(_unreadMsgs.toString()))))
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 300.0,
                    color: Colors.red,
                    child: Center(
                        child: Text(
                      _currentIndex == 1 ? '</home>' : '</social>',
                      style: TextStyle(fontSize: 32.0),
                    )),
                  ))
        // // constraints: BoxConstraints.expand(),
        // child: _currentIndex == 0 ? ChatLayout() : (_currentIndex == 1 ? HomeLayout() : SocialLayout()))),
        );
  }

  Widget buildFlutterTicketWidget() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.5,
      color: AppColors.backGroundBlack,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'hello, joeydash',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600, color: AppColors.white),
                ),
                IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 28.0,
                      color: AppColors.brownie,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'cheemde says machine learning a day keeps the doctor away',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: AppColors.lightGrey),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Text(
              'total wallet balance',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.lightGrey),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              'INR 20k',
              style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600, color: AppColors.white),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'which is equal to ',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: AppColors.lightGrey),
                ),
                Text(
                  '20k doge money',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: AppColors.brownie),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.08,
            ),
            SizedBox(
              height: screenHeight * .07,
              child: NeuLeadButton(
                icon: Icon(
                  Icons.credit_card,
                  color: Colors.black,
                ),
                onPressed: () {},
                child: Text(
                  'add money',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
