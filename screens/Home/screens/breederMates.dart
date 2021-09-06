import 'package:flutter/material.dart';
import 'info.dart';
import '../../../helpers/api/api.dart';
import '../../../helpers/storage/storage.dart';
import '../../../helpers/models/User.dart';
import '../../loadingScreen.dart';
import '../../../helpers/dialog/dialog.dart';
import './chat.dart';

class FindMates extends StatefulWidget {
  final breeder;

  FindMates(this.breeder);
  @override
  _FindMatesState createState() => _FindMatesState();
}

class _FindMatesState extends State<FindMates> with TickerProviderStateMixin {
  Animation<double> nextAnimation;
  AnimationController nextController;

  Animation<double> leftAnimation;
  AnimationController leftController;

  Animation<double> likeAnimation;
  AnimationController likeController;

  bool rerender = true;
  bool likes = false;
  bool completed = false;
  bool userFound = false;
  int selectedPic = 0;
  List pictures = ["", ""];
  var bredderinfo;
  void initState() {
    super.initState();
    data();

    nextController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    nextAnimation = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: nextController,
        curve: Curves.easeIn,
      ),
    );

    leftController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    leftAnimation = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: leftController,
        curve: Curves.easeIn,
      ),
    );

    likeController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    likeAnimation = Tween(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: likeController,
        curve: Curves.easeIn,
      ),
    );
  }

  void data() async {
    var image1 = widget.breeder['imageUrl1'];
    var image2 = widget.breeder['imageUrl2'];
    var image3 = widget.breeder['imageUrl3'];
    var image4 = widget.breeder['imageUrl4'];
    try {
      await getpics(image1, image2, image3, image4);
      setState(() {
        bredderinfo = data;
        completed = true;
        userFound = true;
      });
    } catch (e) {
      setState(() {
        completed = true;
      });
    }
  }

  getpics(image1, image2, image3, image4) async {
    var imageUrl1 = await getImageurl(image1);
    var imageUrl2 = await getImageurl(image2);
    var imageUrl3 = await getImageurl(image3);
    var imageUrl4 = await getImageurl(image4);

    setState(() {
      pictures = [imageUrl1, imageUrl2, imageUrl3, imageUrl4];
    });
  }

  void backPic() {
    setState(() {
      if (selectedPic > 0) {
        selectedPic--;
      }
    });
  }

  void nextPic() {
    if (selectedPic < 3) {
      setState(() {
        selectedPic++;
      });
    }
  }

  Widget build(BuildContext context) {
    return completed
        ? (Scaffold(
            body: userFound
                ? Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height,
                    child: (Column(children: [
                      Container(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(
                          children: [
                            card(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: backPic,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    DogInfo dogInformation = new DogInfo(
                                        pictures, widget.breeder, selectedPic);
                                    Navigator.pushNamed(
                                        context, InfoScreen.routeName,
                                        arguments: dogInformation);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                  ),
                                ),
                                InkWell(
                                  onTap: nextPic,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height: 5,
                                  color: selectedPic == 0
                                      ? Colors.amber
                                      : Colors.black26,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height: 5,
                                  color: selectedPic == 1
                                      ? Colors.amber
                                      : Colors.black26,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height: 5,
                                  color: selectedPic == 2
                                      ? Colors.amber
                                      : Colors.black26,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height: 5,
                                  color: selectedPic == 3
                                      ? Colors.amber
                                      : Colors.black26,
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                ),
                                message(),
                                leftCircleAnimation(),
                                rightCrileAnimations(),
                                likeCircleAnimation(),
                                Container(
                                  width: 10,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      info(),
                      Container(
                        height: 10,
                      ),
                    ])),
                  )
                : (Center(
                    child: Text(
                      'No user found',
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 28),
                    ),
                  )),
          ))
        : (LoadingScreen());
  }

  Widget rightCrileAnimations() {
    return AnimatedBuilder(
      animation: nextAnimation,
      builder: (context, child) {
        return Transform.scale(scale: nextAnimation.value, child: child);
      },
      child: rightCrile(),
    );
  }

  Widget rightCrile() {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        iconSize: 30,
        icon: Icon(Icons.arrow_forward_ios_rounded),
        color: Colors.black,
        onPressed: () async {
          nextPic();
          await nextController.forward();
          if (nextController.status == AnimationStatus.completed) {
            nextController.reverse();
          }
        },
      ),
    );
  }

  Widget message() {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        iconSize: 30,
        icon: Icon(Icons.message_rounded),
        color: Colors.black,
        onPressed: () async {
          var data = await chatRoom(
              widget.breeder['dogId'], pictures[0], widget.breeder['dogname']);
          print('my response $data');
          var id = data['chatId'];

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat('$id', widget.breeder['dogname'],
                      widget.breeder['dogId'], pictures[0])));
        },
      ),
    );
  }

  Widget leftCircleAnimation() {
    return AnimatedBuilder(
      animation: leftAnimation,
      builder: (context, child) {
        return Transform.scale(scale: leftAnimation.value, child: child);
      },
      child: leftCircle(),
    );
  }

  Widget leftCircle() {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        iconSize: 30,
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.black,
        onPressed: () async {
          backPic();
          await leftController.forward();

          if (leftController.status == AnimationStatus.completed) {
            leftController.reverse();
          }
        },
      ),
    );
  }

  Widget likeCircleAnimation() {
    return AnimatedBuilder(
      animation: likeAnimation,
      builder: (context, child) {
        return Transform.scale(scale: likeAnimation.value, child: child);
      },
      child: likeCircle(),
    );
  }

  Widget likeCircle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.favorite),
              color: likes ? (Colors.red) : (Colors.amber),
              onPressed: () async {
                setState(() {
                  likes = true;
                });

                await likeController.forward();

                if (likeController.status == AnimationStatus.completed) {
                  await likeController.reverse();
                }

                var res = await getLikeInfo(widget.breeder['dogId']);
                print(res);
                if (res['msg'] == 'is a match') {
                  matchDialog(
                      context, 'Breeder  match', "you match with the user", () {
                    Navigator.pop(context);
                  }, pictures[selectedPic], widget.breeder['dogname']);
                } else {}
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                widget.breeder['dogname'],
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          Column(
            children: [
              Text('Gender',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.all(5),
                color: widget.breeder['gender'] == "Male"
                    ? (Colors.blue)
                    : (Colors.pink),
                child: Text(
                  widget.breeder['gender'],
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('Age',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                widget.breeder['age'],
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget card() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          image: NetworkImage(pictures[selectedPic]),
        ),
      ),
    );
  }
}
