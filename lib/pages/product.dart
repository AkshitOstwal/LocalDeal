import 'dart:async';

import '../widgets/ui_elements/title_default.dart';
import '../scoped-models/products.dart';

import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;
  ProductPage(this.productIndex);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[Icon(Icons.warning), Text('Are you sure!')],
            ),
            content: Text("This action cant be undone!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Discard'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Continue'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Jaiput,Rajasthan',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '₹ ' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button Pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductModel>(
        builder: (BuildContext context, Widget child, ProductModel model) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.products[productIndex].title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(model.products[productIndex].image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(model.products[productIndex].title),
                ),
                _buildAddressPriceRow(model.products[productIndex].price),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    model.products[productIndex].description,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
