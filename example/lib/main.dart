import 'package:flutter/material.dart';
import 'package:capture_and_share/capture_and_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 300,
                color: Colors.green,
              ),
              Container(
                height: 150,
                width: 400,
                color: Colors.pink,
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    CaptureAndShare.shareIt(
                      sizeWidth: 300,
                      sizeHeight: 300,
                      xMode: 'center',
                      yMode: 'center',
                    );
                  },
                  child: Text('Click'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
