// import 'dart:developer';
import 'dart:math';

import 'package:whatsub/components/neu_button.dart';
import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ChatLayout extends StatefulWidget {
  @override
  _ChatLayoutState createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              AnimatedContainer(
                color: AppColors.backGroundBlack,
                height: screenHeight * 0.075,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: screenWidth * 0.55,
                duration: Duration(milliseconds: 2000),
                child: !isSearching
                    ? Text('chats', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 22.0))
                    :
                    // ClipRRect(
                    //     borderRadius: BorderRadius.circular(90.0),
                    //     child: Container(
                    //       margin: EdgeInsets.symmetric(vertical: 8.0),
                    //       decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(90.0)),
                    //       width: screenWidth * 0.55,
                    //       child: NeumorphicButton(

                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             hintText: 'Search',
                    //             border: InputBorder.none,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    NeumorphicButton(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            fillColor: AppColors.backGroundGrey,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
              ),
              Spacer(),
              SizedBox(
                  width: screenHeight * 0.075 - 16.0,
                  height: screenHeight * 0.075 - 16.0,
                  child: NeuButton(
                      border: 2.0,
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                      child: Center(child: Icon(isSearching ? Icons.clear : Icons.search)))),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: screenHeight * 0.1,
              color: Colors.primaries[Random().nextInt(11)],
            );
          },
        ),
      ],
    );
  }
}
