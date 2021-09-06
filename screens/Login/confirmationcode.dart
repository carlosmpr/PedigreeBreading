import 'package:flutter/material.dart';
import '../../helpers/auth/auth.dart';
import '../../helpers/models/User.dart';
import './extrainfo.dart';
import '../../helpers/dialog/dialog.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  static const routeName = '/confirmation';

  @override
  _ConfirmationCodeScreenState createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final formkey = GlobalKey<FormState>();
  String code = '';
  @override
  Widget build(BuildContext context) {
    final User args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                ),
                passwordField(),
                Container(
                  height: 25,
                ),
                submitButton(args.mail, args.pass)
              ],
            ),
          )),
    );
  }

  Widget passwordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Enter code', hintText: 'code'),
        onSaved: (String value) {
          code = value;
          print(code);
        },
      ),
    );
  }

  Widget submitButton(email, password) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            ("Submit"),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            formkey.currentState.save();

            var result = await confirnmCode(code, email);
            if (result) {
              try {
                await signinUser(email, password);
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    ExtraInformationPage.routeName,
                    ((Route<dynamic> route) => false),
                    arguments: email);
              } catch (err) {
                print(err);
              }
            } else {
              showMaterialDialog(
                  context, "Error", "code incorrect please try again");
            }
          }),
    );
  }
}
