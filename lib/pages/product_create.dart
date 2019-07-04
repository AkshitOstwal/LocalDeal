import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter Tilte of Product',
            ),
            onChanged: (String value) {
              setState(() {
                _titleValue = value;
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
                _descriptionValue = value;
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
                _priceValue = double.parse(value);
              });
            },
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              Map<String, dynamic> product = {
                'title': _titleValue,
                'description': _descriptionValue,
                'price': _priceValue,
                'image': 'assets/food.jpg'
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
