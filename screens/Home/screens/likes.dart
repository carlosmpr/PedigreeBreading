import 'package:flutter/material.dart';
import '../../../helpers/api/api.dart';
import '../../../helpers/storage/storage.dart';
import './chat.dart';
import '../../loadingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesScreen extends StatefulWidget {
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  var userMatchets = [];
  var chatRooms = [];
  var userinfo = [];
  bool completed = false;
  bool rerender = false;
  int likes = 0;
  void initState() {
    super.initState();
    data();
  }

  void renderAgain() {
    setState(() {
      rerender = !rerender;
    });
  }

  void data() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> user = (prefs.getStringList('data') ?? [""]);
      var data = await getMatchInfo();
      print(data['body']);
      var chats = await getChatInfo();
      if (user.length > 0) {
        userinfo = user;
      }
      if (data.length > 0) {
        userMatchets = data['body'];
        likes = data['info'];
      }

      if (chats.length > 0) {
        chatRooms = chats;
      }
    } catch (e) {
      print(e);
    }

    // userMatchets = data['body'];
    // chatRooms = chats;
    // likes = data['info'];
    // var image1 = data[count]['imageUrl1'];

    // await getpics(image1, image2, image3, image4);
    setState(() {
      // likes = data['info'];
      // userMatchets = data['body'];
      completed = true;
    });
    print('My likes data');
    print(chatRooms[0]);
  }

  @override
  Widget build(BuildContext context) {
    return completed
        ? (Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('My Mates'),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Matches',
                        style: TextStyle(fontSize: 25, fontFamily: 'Pacifico')),
                    Text('Secrets admires',
                        style: TextStyle(fontSize: 13, fontFamily: 'Pacifico')),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.amber,
                      child: Text('$likes'),
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: userMatchets.length > 0
                      ? (ListView.builder(
                          itemCount: userMatchets.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return MatchesAvatar(
                                userMatchets[index]['dogname'],
                                userMatchets[index]['imageUrl1'],
                                userMatchets[index]['dogId']);
                          }))
                      : (Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Secrets admires',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Pacifico')),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber,
                              child: Text('$likes'),
                              foregroundColor: Colors.white,
                            ),
                          ],
                        )),
                ),
                Text('Messages',
                    style: TextStyle(fontSize: 25, fontFamily: 'Pacifico')),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: chatRooms.length > 0
                      ? (ListView.builder(
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            if (userinfo[1] == chatRooms[index]['userId2']) {
                              return ChatRooms(
                                  chatRooms[index]['chatId'],
                                  chatRooms[index]['userId1'],
                                  chatRooms[index]['user1Name'],
                                  chatRooms[index]['photo1']);
                            } else {
                              return ChatRooms(
                                  chatRooms[index]['chatId'],
                                  chatRooms[index]['userId2'],
                                  chatRooms[index]['user2Name'],
                                  chatRooms[index]['photo2']);
                            }
                          }))
                      : Center(child: (Text('No Chats'))),
                )
              ],
            )))
        : (LoadingScreen());
  }
}

class ChatRooms extends StatefulWidget {
  final int chatId;
  final String userId;
  final String username;
  final String photo;

  ChatRooms(this.chatId, this.userId, this.username, this.photo);
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  var photourl = "";
  var messages;
  bool msg = false;
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    var image = await getImageurl(widget.photo);
    var data = await getMessage(widget.chatId);
    if (data.length > 0) {
      messages = data;
      setState(() {
        msg = true;
      });
    }
    setState(() {
      photourl = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Chat('${widget.chatId}', widget.username,
                    widget.userId, photourl)));
      },
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(photourl),
              ),
              title: Text(widget.username),
              subtitle:
                  msg ? (Text(messages[0]['message'])) : Text('no messages'),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchesAvatar extends StatefulWidget {
  final String name;
  final String photo;
  final String userId2;

  MatchesAvatar(
    this.name,
    this.photo,
    this.userId2,
  );
  @override
  _MatchesAvatarState createState() => _MatchesAvatarState();
}

class _MatchesAvatarState extends State<MatchesAvatar> {
  var photourl = "";

  void initState() {
    super.initState();
    data();
  }

  void data() async {
    var image = await getImageurl(widget.photo);

    setState(() {
      photourl = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userId2);
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              var data =
                  await chatRoom(widget.userId2, widget.photo, widget.name);
              print('my response $data');
              var id = data['chatId'];

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Chat('$id', widget.name, widget.userId2, photourl)));
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(photourl),
            ),
          ),
          Text(widget.name),
        ],
      ),
    );
  }
}
