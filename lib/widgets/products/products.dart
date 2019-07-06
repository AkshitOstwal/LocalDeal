import './product_card.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products) {
    print('[Product Widget ] constructor');
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context , int index)=> ProductCard( products[index],index),
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
    return _buildProductList();
  }
}
