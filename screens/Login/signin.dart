import 'package:flutter/material.dart';
import '../../helpers/dialog/dialog.dart';
import '../../helpers/auth/auth.dart';
import '../../helpers/models/User.dart';
import 'confirmationcode.dart';
import '../Home/landing.dart';
import './form/forgotpassword.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formkey = GlobalKey<FormState>();
  bool signin = true;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          signin ? ('Signin') : ('Signup'),
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pedigree Breeding Co',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Image(
                          image: AssetImage('assets/img/icon.png'),
                          height: 10,
                          width: 10),
                    ),
                  ],
                ),
                Container(
                  height: 25,
                ),
                emailField(node),
                passwordField(),
                Container(
                  margin: EdgeInsets.only(top: 25),
                ),
                fortgotPassword(),
                Container(
                  margin: EdgeInsets.only(top: 25),
                ),
                submitButton(),
                Container(
                  margin: EdgeInsets.only(top: 25),
                ),
                info(),
                Container(
                  height: 25,
                ),
                infoprivacy(),
                Container(
                  height: 25,
                ),
              ],
            ),
          )),
    );
  }

  Widget emailField(node) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email Address',
          hintText: 'example@gmail.com',
        ),
        onEditingComplete: () => node.nextFocus(),
        validator: (String value) {
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
        onSaved: (String value) {
          email = value;
        },
      ),
    );
  }

  Widget passwordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        obscureText: true,
        decoration:
            InputDecoration(labelText: 'Enter Password', hintText: 'Password'),
        validator: (String value) {
          if (value.length < 4) {
            return 'Password must be at least 4 character';
          }
          return null;
        },
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  Widget fortgotPassword() {
    return Visibility(
        visible: signin,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
          },
          child: Text(
            'Forgot your password?',
            style: TextStyle(color: Colors.blue),
          ),
        ));
  }

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            signin ? ("Signin") : ("Signup"),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();

              if (signin) {
                try {
                  var issignin = await signinUser(email, password);
                  if (issignin) {
                    Navigator.pushReplacementNamed(
                        context, LandingPage.routeName);
                  }
                } catch (err) {
                  showMaterialDialog(
                      context, "Error", "Check email address or password");
                }
              } else {
                try {
                  await registeruser(email, password);

                  var user = new User(email, password);

                  Navigator.pushNamed(context, ConfirmationCodeScreen.routeName,
                      arguments: user);
                } catch (err) {
                  print(err);
                }
              }
            }
          }),
    );
  }

  Widget info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            signin ? ("Don't have an Account?") : ("Already have an Account?")),
        Container(
          width: 30,
        ),
        InkWell(
          onTap: () {
            setState(() {
              signin = !signin;
            });
          },
          child: Text(
            signin ? ('Sing up here') : ('Log In'),
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget infoprivacy() {
    return Column(
      children: [
        Image.asset(('assets/img/icon.png'), height: 120, width: 120),
        Container(
          height: MediaQuery.of(context).size.width * 0.25,
        ),
        InkWell(
          onTap: () {
            termsOfservice(context);
          },
          child: Text(
            'Terms of Service',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Container(
          height: 20,
        ),
        InkWell(
          onTap: () {
            privacyDialog(context);
          },
          child: Text(
            'Privacy Policy',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
