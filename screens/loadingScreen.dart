import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'loading',
              style: Theme.of(context).textTheme.headline5,
            ),
            CollectionScaleTransition(
              children: <Widget>[
                Image(
                    image: AssetImage('assets/img/icon.png'),
                    height: 60,
                    width: 60),
                SizedBox(
                  width: 25,
                ),
                Image(
                    image: AssetImage('assets/img/icon.png'),
                    height: 60,
                    width: 60),
              ],
            ),
            JumpingDotsProgressIndicator(
              fontSize: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
