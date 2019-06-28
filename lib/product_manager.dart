import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String,String> startingProduct;

  ProductManager({this.startingProduct}) {
    print('[ProductManager widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[productmanager widget] CreateState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String,String>> _products =
      []; //in .add add a new value and not assigning it so we can mark it final also

  @override
  void initState() {
    print('[_productmanagerstate] initstate()');
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[_productManagerstate] didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  void _addProducts(Map<String,String> product) {
    //creatring this so we can access the setState in product_control
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index){
    _products.removeAt(index);
  }
  @override
  Widget build(BuildContext context) {
    print('[_productmanagerstate] Build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(
              _addProducts), // we are passing the function reference only here
        ),
        // use Container(height:300 , child: Products(_products)), for fixed amaount of scrollable panel
        Expanded(child: Products(_products, deleteProduct: _deleteProduct)),
      ],
    );
  }
}
