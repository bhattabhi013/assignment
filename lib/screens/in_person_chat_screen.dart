import 'package:bubble/bubble.dart';
import 'package:whatsub/util/constants.dart';
import 'package:whatsub/util/dummy_data.dart';
import 'package:flutter/material.dart';

class InChatScreen extends StatefulWidget {
  final String name;

  const InChatScreen({required this.name});
  @override
  _InChatScreenState createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  TextEditingController _messageController= TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.backGroundGrey,
        appBar: AppBar(
          titleSpacing: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                width: AppBar().preferredSize.height * 0.8,
                height: AppBar().preferredSize.height * 0.8,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: msgs.length,
              reverse: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: screenHeight * 0.08),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: msgs[index].isMe
                      ? Bubble(
                          margin: BubbleEdges.only(
                            top: (index < msgs.length - 1 && msgs[index + 1].isMe) ? 5.0 : 20.0,
                            left: screenWidth / 4.5,
                          ),
                          nip: (index < msgs.length - 2 && msgs[index + 1].isMe) ? BubbleNip.no : BubbleNip.rightTop,
                          color: Colors.red.shade100,
                          nipHeight: (12.0),
                          alignment: Alignment.centerRight,
                          elevation: 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                msgs[index].msg,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              SizedBox(
                                height: (10.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    msgs[index].time,
                                    style: TextStyle(fontSize: (10.0), color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: (10.0),
                                  ),
                                  Icon(
                                    msgs[index].sent ? Icons.check : Icons.done_all_outlined,
                                    color: msgs[index].seen ? Colors.blue : Colors.grey,
                                    size: 16.0,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Bubble(
                          margin: BubbleEdges.only(
                              top: (index < msgs.length - 2 && msgs[index + 1].isMe) ? (20.0) : (5.0), right: (100.0)),
                          nip: (index < msgs.length - 1 && msgs[index + 1].isMe) ? BubbleNip.leftTop : BubbleNip.no,
                          nipHeight: (12.0),
                          alignment: Alignment.centerLeft,
                          elevation: 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                msgs[index].msg,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              SizedBox(
                                height: (10.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    msgs[index].time,
                                    style: TextStyle(fontSize: (10.0), color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.05,
                width: screenWidth,
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.82,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                        child: TextField(
                          controller: _messageController,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: AppColors.white),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: (20.0)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.attachment,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: (15.0)),
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.grey,
                                size: 30.0,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenHeight * 0.05,
                      child: CircleAvatar(
                          radius: (screenHeight * 0.05 / 2),
                          backgroundColor: Colors.blue,
                          child: Center(
                            child: Icon(
                              Icons.send,
                              size: 24.0,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
