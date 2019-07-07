import 'package:firstapp/pages/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductListPage(this.products);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(products[index]['image']),
          title: Text(
            products[index]['title'],
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductEditPage(product: products[index]);
                  },
                ),
              );
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
