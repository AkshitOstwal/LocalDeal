import "package:flutter/material.dart";

class ProductPage extends StatelessWidget {
  final String title , imageUrl;
  ProductPage(this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(imageUrl),
          Container(padding: EdgeInsets.all(5),child:Text('on the product page')),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text('Delete'),
            onPressed: () => Navigator.pop(context, true),
          )
        ],
      ),
    );
  }
}