import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);
  @override
  Widget build(BuildContext context) {
    print('[_productmanagerstate] Build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(
              addProduct), // we are passing the function reference only here
        ),
        // use Container(height:300 , child: Products(_products)), for fixed amaount of scrollable panel
        Expanded(child: Products(products, deleteProduct: deleteProduct)),
      ],
    );
  }
}
