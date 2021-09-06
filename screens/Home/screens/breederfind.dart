import 'package:flutter/material.dart';
import '../../../helpers/api/api.dart';
import '../../loadingScreen.dart';
import './breederMates.dart';

class FindBreeder extends StatefulWidget {
  @override
  _FindBreederState createState() => _FindBreederState();
}

class _FindBreederState extends State<FindBreeder>
    with TickerProviderStateMixin {
  bool completed = false;
  bool userFound = false;
  var bredderinfo;
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    var data = await getAllInfo();

    if (data.length > 0) {
      bredderinfo = data;
      try {
        setState(() {
          completed = true;
          userFound = true;
        });
      } catch (e) {}
    } else {
      setState(() {
        completed = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return completed
        ? (Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Mates",
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 28),
              ),
            ),
            body: userFound
                ? Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: bredderinfo.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey[200],
                            margin: EdgeInsets.all(15),
                            height: MediaQuery.of(context).size.height * 0.54,
                            child: FindMates(bredderinfo[index]),
                          );
                        }))
                : (Center(
                    child: Text(
                      'No user found',
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 28),
                    ),
                  )),
          ))
        : (LoadingScreen());
  }
}
