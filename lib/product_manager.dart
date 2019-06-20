import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';
class ProductManager extends StatefulWidget {
  final String startingProduct;
  ProductManager({this.startingProduct = 'Sweets Tester'}){
    print('[ProductManager widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[productmanager widget] CreateState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = []; //in .add add a new value and not assigning it so we can mark it final also

  @override
  void initState() {
    print('[_productmanagerstate] initstate()');
    _products.add(widget.startingProduct);
    super.initState();
  }
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[_productManagerstate] didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  void _addProducts(String product){ //creatring this so we can access the setState in product_control
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[_productmanagerstate] Build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProducts), // we are passing the function reference only here
        ),
        Products(_products)
      ],
    );
  }
}
