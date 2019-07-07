import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductListPage(this.products);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        ListTile(
          leading: Image.asset(products[index]['image']),
          title: Text(
            products[index]['title'],
          ),
          trailing: Icon(Icons.edit),
        );
      },
      itemCount: products.length,
    );
  }
}
