import './product_create.dart';
import './product_list.dart';

import 'package:flutter/material.dart';

class ProductAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;
  final List<Map<String,dynamic>> products;

  ProductAdminPage(this.addProduct, this.deleteProduct, this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("All Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text("Manage Products"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: "Create Product",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "My Product",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(addProduct),
              ProductListPage(products),
            ],
          ),
        ),
      ),
    );
  }
}
