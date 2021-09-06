import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../helpers/auth/auth.dart';
import './Home/landing.dart';
import 'Login/signin.dart';
import './loadingScreen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool user = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _fetchSession();
  }

  _fetchSession() async {
    try {
      await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      setState(() {
        user = true;
        completed = true;
      });
    } on AuthException catch (e) {
      setState(() {
        user = false;
        completed = true;
      });
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return completed
        ? (Scaffold(body: user ? LandingPage() : SigninPage()))
        : (LoadingScreen());
  }
}
