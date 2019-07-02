import 'dart:async';
import "package:flutter/material.dart";

class ProductPage extends StatelessWidget {
  final String title, imageUrl;
  ProductPage(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button Pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Delete'),
                onPressed: () => Navigator.pop(context, true),
              ),
            )
          ],
        ),
      ),
    );
  }
}
