import 'package:firstapp/models/product.dart';
import 'package:firstapp/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_card.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {

  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context , int index)=> ProductCard( products[index]),
        itemCount: products.length,
      );
      print(products);
    } else {
      productCards = Center(
        child: Text('No item found , try adding one!!'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Product Widget] build()');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child ,MainModel model){
     return  _buildProductList(model.dislpayedProducts);
    },);
  }
}
