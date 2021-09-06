import 'package:flutter/material.dart';
import '../../helpers/auth/auth.dart';
import './screens/breederfind.dart';
import './screens/likes.dart';
import './screens/profile.dart';
import './screens/training.dart';
import '../../helpers/api/api.dart';
import '../Login/extrainfo.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var data = await userInformation();
    if (data.length <= 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ExtraInformationPage()));
    }
    print(data);
  }

  final List<Widget> _pages = [
    TrainingScreen(),
    FindBreeder(),
    LikesScreen(),
    ProfileScreen()
  ];

  int _selectedPAgeIndex = 1;
  void _selectPage(int index) {
    setState(() {
      _selectedPAgeIndex = index;
    });
  }

  bool data = true;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      if (data) {
        setState(() {
          _selectedPAgeIndex = args;
          data = false;
        });
      }
    }

    print(args);
    print(_selectedPAgeIndex);
    return Scaffold(
      body: _pages[_selectedPAgeIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.black),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber,
        onTap: _selectPage,
        backgroundColor: Colors.white,
        currentIndex: _selectedPAgeIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Mates'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Likes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
