import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter Tilte of Product',
            ),
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Enter Description of product',
            ),
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Price',
              hintText: 'Enter Price',
            ),
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
            keyboardType: TextInputType.number,
          ),
          RaisedButton(child: Text('Save'),onPressed:() {},),
        ],
      ),
    );
  }
}
