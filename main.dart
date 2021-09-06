import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import './screens/home.dart';
import './screens/Login/confirmationcode.dart';
import './screens/Login/extrainfo.dart';
import './screens/Home/landing.dart';
import './screens/Home/screens/info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PedigreeBreeding',
        theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.purple,
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 32.0,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w900),
              headline5: TextStyle(
                fontSize: 39.0,
                fontFamily: 'Pacifico',
              ),
              headline6: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Pacifico',
              ),
              button: TextStyle(fontSize: 22, fontFamily: 'Pacifico'),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            )),
        home: Homepage(),
        routes: {
          ConfirmationCodeScreen.routeName: (context) =>
              ConfirmationCodeScreen(),
          ExtraInformationPage.routeName: (context) => ExtraInformationPage(),
          LandingPage.routeName: (context) => LandingPage(),
          InfoScreen.routeName: (context) => InfoScreen()
        });
  }
}
