import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function
      addProduct; // creating a function to get reference of _addProduct form Product_manager.dart
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        addProduct({'title': 'Choclate', 'image': 'assets/food.jpg'});
      },
      child: Text('Add Product'),
    );
  }
}
