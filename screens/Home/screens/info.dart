import 'package:flutter/material.dart';
import '../../../helpers/models/User.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info-screen';
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final DogInfo dogInformation = ModalRoute.of(context).settings.arguments;
    int selectedPic = dogInformation.currentPic + count;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          dogInformation.ingoDog['dogname'],
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                    image: NetworkImage(dogInformation.pictures[selectedPic]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedPic > 0) {
                          count--;
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (selectedPic < 3) {
                        print(selectedPic);
                        setState(() {
                          count++;
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 5,
                    color: selectedPic == 0 ? Colors.amber : Colors.black26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 5,
                    color: selectedPic == 1 ? Colors.amber : Colors.black26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 5,
                    color: selectedPic == 2 ? Colors.amber : Colors.black26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 5,
                    color: selectedPic == 3 ? Colors.amber : Colors.black26,
                  ),
                ],
              ),
            ]),
            Container(
              height: 5,
            ),
            Container(
              height: 25,
            ),
            Text(
              'Info',
              textAlign: TextAlign.start,
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 22),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.94,
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 25,
                    ),
                    Text(
                      dogInformation.ingoDog['breederType'],
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 22),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Text(
                              'Tempered',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pacifico'),
                            ),
                            Text(dogInformation.ingoDog['tempered']),
                          ]),
                          Column(children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pacifico'),
                            ),
                            Text(dogInformation.ingoDog['gender']),
                          ]),
                          Column(children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pacifico'),
                            ),
                            Text(dogInformation.ingoDog['age']),
                          ]),
                        ]),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        dogInformation.ingoDog['bio'],
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Like'),
                          onPressed: () {/* ... */},
                        ),
                        TextButton(
                          child: const Text('Papers verifications'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
