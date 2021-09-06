import 'package:flutter/material.dart';

class BuyerForm extends StatefulWidget {
  final String typeOfUser;
  const BuyerForm({Key key, this.typeOfUser}) : super(key: key);

  @override
  _BuyerFormState createState() => _BuyerFormState();
}

class _BuyerFormState extends State<BuyerForm> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Form(
            key: formkey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                  ),
                  Text(
                    widget.typeOfUser,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Image.network(
                      ('http://clipart-library.com/images/8czno86ji.png'),
                      height: 120,
                      width: 120),
                  Container(
                    height: 25,
                  ),
                  emailField(),
                  passwordField(),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                  ),
                  submitButton(),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                  ),
                ],
              ),
            )),
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

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            ("Save"),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
              try {
                // await registeruser(email, password);
                // var user = new User(email, password);
                // Navigator.pushNamed(context, ConfirmationCodeScreen.routeName,
                //     arguments: user);
              } catch (err) {
                print(err);
              }
            }
          }),
    );
  }
}
