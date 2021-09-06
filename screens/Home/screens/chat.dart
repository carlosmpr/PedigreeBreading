import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import '../../../helpers/api/api.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import '../../Home/landing.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class Chat extends StatefulWidget {
  static const routename = '/chat-room';
  final String chatId;
  final String name;
  final String uId;
  final String photo;

  Chat(this.chatId, this.name, this.uId, this.photo);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final myController = TextEditingController();
  bool render = false;
  String message = "";
  bool complete = false;
  var messeges = [];
  Timer timer;
  @override
  void initState() {
    super.initState();
    getdata(widget.chatId);
  }

  void getdata(chatId) async {
    var data = await getMessage(chatId);
    if (data.length > 0) {
      setState(() {
        messeges = data;
        render = true;
      });
    }
    print(messeges);
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    timer?.cancel();
    myController.dispose();
    super.dispose();
  }

  ScrollController _scrollController = new ScrollController();
  var parser = EmojiParser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LandingPage.routeName,
                      arguments: 2);
                }),
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(widget.photo),
            ),
            SizedBox(
              width: 50,
            ),
            Text(widget.name),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              child: messeges.length > 0
                  ? (ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messeges.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(
                                left: 15, bottom: 10, top: 5, right: 15),
                            child: bubbleMessage(messeges[index]['userId'],
                                messeges[index]['message']));
                      }))
                  : Center(child: (Text('no message'))),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Send Message'),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 45,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        var data = await sendMessage(
                            widget.chatId, parser.unemojify(myController.text));
                        print(data);
                        myController.clear();
                        setState(() {
                          messeges = data;
                          complete = !complete;
                          if (render) {
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          }
                          render = true;
                        });

                        Timer.periodic(Duration(seconds: 15), (Timer t) {
                          t.cancel();
                          getdata(widget.chatId);
                          print('klk');
                        });
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bubbleMessage(uid, messege) {
    if (uid == widget.uId) {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            parser.emojify(messege),
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.green[100],
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            parser.emojify(messege),
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
  }
}
