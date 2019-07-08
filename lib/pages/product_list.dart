import 'package:firstapp/pages/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;
  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _bulidEditButton(BuildContext context,int index){
    return IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductEditPage(
                            product: products[index],
                            updateProduct: updateProduct,
                            productIndex: index,
                          );
                        },
                      ),
                    );
                  },
                );
  }

  Widget _buildDeleteBackground(){
    return Container(
            color: Colors.red,
            child: Row(
              children: <Widget>[
                Text(
                  "DELETE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 15,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index]['title']),
          background: _buildDeleteBackground(),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
            }
          },
          direction: DismissDirection.endToStart,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index]['image']),
                  radius: 25,
                ),
                title: Text(
                  products[index]['title'],
                ),
                subtitle: Text('₹ ${products[index]['price']}'),
                trailing: _bulidEditButton(context, index),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
