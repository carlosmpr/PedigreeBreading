import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import '../../../helpers/dialog/dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();
  bool passwordReset = false;
  String email = '';
  String password = '';
  String confirmation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Passowrd reset",
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
                Text(
                  'Pedigree Breeding',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  height: 25,
                ),
                Visibility(visible: passwordReset, child: confirmationCode()),
                emailField(),
                Visibility(visible: passwordReset, child: passwordField()),
                Container(
                  margin: EdgeInsets.only(top: 25),
                ),
                submitButton(),
                Container(
                  margin: EdgeInsets.only(top: 25),
                ),
                Container(
                  height: 25,
                ),
                infoprivacy()
              ],
            ),
          )),
    );
  }

  Widget passwordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Enter new password', hintText: 'Password'),
        validator: (String value) {
          if (value.length < 8) {
            return 'Password must be at least 8 character';
          }
          return null;
        },
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  Widget confirmationCode() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Enter confirmation code', hintText: 'Password'),
        validator: (String value) {
          if (value.length < 4) {
            return 'Code must be at least 4 character';
          }
          return null;
        },
        onSaved: (String value) {
          confirmation = value;
        },
      ),
    );
  }

  Widget emailField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email Address',
          hintText: 'example@gmail.com',
        ),
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

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "reset password",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
              if (passwordReset) {
                try {
                  await Amplify.Auth.confirmPassword(
                      username: email,
                      newPassword: password,
                      confirmationCode: confirmation);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              } else {
                try {
                  ResetPasswordResult res = await Amplify.Auth.resetPassword(
                    username: email,
                  );

                  setState(() {
                    passwordReset = true;
                  });
                } catch (e) {
                  showMaterialDialog(context, "Error", "Check email address");
                }
              }
            }
          }),
    );
  }

  Widget infoprivacy() {
    return Column(
      children: [
        Image.network(('http://clipart-library.com/images/8czno86ji.png'),
            height: 120, width: 120),
        Container(
          height: MediaQuery.of(context).size.width * 0.25,
        ),
        Text(
          'Terms of Service',
          style: TextStyle(color: Colors.blue),
        ),
        Container(
          height: 20,
        ),
        Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}
