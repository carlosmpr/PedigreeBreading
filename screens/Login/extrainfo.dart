import 'package:flutter/material.dart';
import './form/breederForm.dart';
import './form/buyerForm.dart';
import './form/sellerForm.dart';

class ExtraInformationPage extends StatefulWidget {
  static const routeName = '/extra';
  @override
  _ExtraInformationPageState createState() => _ExtraInformationPageState();
}

class _ExtraInformationPageState extends State<ExtraInformationPage> {
  String you = 'Breeder';
  String uid;

  formSelection(value, email) {
    switch (value) {
      case 'Seller':
        {
          return SellerForm(typeOfUser: 'Seller');
        }
        break;

      case 'Buyer':
        {
          return BuyerForm(typeOfUser: 'Buyer');
        }
        break;

      default:
        {
          return BreederForm(typeOfUser: 'Breeder', email: email);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Complete information',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
              ),
              Text(
                'I am',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userType('Breeder', Colors.amber),
                  // userType('Buyer', Colors.blue[300]),
                  // userType('Seller', Colors.white)
                ],
              ),
              formSelection(you, args),
            ],
          ),
        ),
      ),
    );
  }

  Widget userType(String value, Color typeColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      child: RaisedButton(
          color: typeColor,
          child: Text(
            value,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            setState(() {
              you = value;
            });
          }),
    );
  }
}
