import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/storage/storage.dart';
import '../../loadingScreen.dart';
import '../../../helpers/api/api.dart';
import '../../../helpers/auth/auth.dart';
import '../../../helpers/phoneLocalStorage/localStorage.dart';
import '../../Login/form/updateUser.dart';
import '../../home.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> profile;
  List<String> pictures;
  bool completed = false;

  void initState() {
    super.initState();
    data();
  }

  void data() async {
    await getData();
    setState(() {
      completed = true;
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = (prefs.getStringList('data') ?? [""]);

    if (data.length > 0) {
      var image1 = await getImageurl(data[9]);
      var image2 = await getImageurl(data[10]);
      var image3 = await getImageurl(data[11]);
      var image4 = await getImageurl(data[12]);
      setState(() {
        profile = data;
        pictures = [image1, image2, image3, image4];
      });
    } else {
      var data = await userInformation();
      var image1 = await getImageurl(data[0]['imageUrl1']);
      var image2 = await getImageurl(data[0]['imageUrl2']);
      var image3 = await getImageurl(data[0]['imageUrl3']);
      var image4 = await getImageurl(data[0]['imageUrl4']);

      await saveUser(
          data[0]['userType'],
          data[0]['userId'],
          data[0]['dogId'],
          data[0]['dogname'],
          data[0]['gender'],
          data[0]['tempered'],
          data[0]['age'],
          data[0]['bio'],
          data[0]['breederType'],
          data[0]['imageUrl1'],
          data[0]['imageUrl2'],
          data[0]['imageUrl3'],
          data[0]['imageUrl4']);

      setState(() {
        profile = [
          data[0]['userType'],
          data[0]['userId'],
          data[0]['dogId'],
          data[0]['dogname'],
          data[0]['gender'],
          data[0]['tempered'],
          data[0]['age'],
          data[0]['bio'],
          data[0]['breederType'],
          data[0]['imageUrl1'],
          data[0]['imageUrl2'],
          data[0]['imageUrl3'],
          data[0]['imageUrl4']
        ];
        pictures = [image1, image2, image3, image4];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return completed
        ? (Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(pictures[0]),
                    ),
                    Text(
                      profile[3],
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Pacifico'),
                                  ),
                                  Text(profile[4])
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Pacifico'),
                                  ),
                                  Text(profile[6])
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tempered',
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Pacifico'),
                                  ),
                                  Text(profile[5])
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Bio",
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Breeder Type",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 25),
                              ),
                              Text(profile[8]),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: Text(
                                  profile[7],
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Photos",
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(pictures[0]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(pictures[1]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(pictures[2]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: IconButton(
                                iconSize: 50,
                                icon: Icon(Icons.location_history),
                                color: Colors.amber,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserInformation(
                                                dogInfo: profile,
                                                imageUrl1: pictures[0],
                                                imageUrl2: pictures[1],
                                                imageUrl3: pictures[2],
                                                imageUrl4: pictures[3],
                                              )));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Papers",
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.folder),
                                color: Colors.amber,
                                onPressed: () {},
                              ),
                              Text(
                                'AKC Registered',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Pacifico'),
                              ),
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.done),
                                color: Colors.green,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.folder),
                                color: Colors.amber,
                                onPressed: () {},
                              ),
                              Text(
                                'DNA Info',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Pacifico'),
                              ),
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.done),
                                color: Colors.green,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.folder),
                                color: Colors.amber,
                                onPressed: () {},
                              ),
                              Text(
                                'Vaccinated',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Pacifico'),
                              ),
                              IconButton(
                                iconSize: 25,
                                icon: Icon(Icons.done),
                                color: Colors.green,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "I'm a User",
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        await signout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      },
                      child: Text(
                        "Singout",
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 16,
                            color: Colors.blue),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ))
        : (LoadingScreen());
  }
}
