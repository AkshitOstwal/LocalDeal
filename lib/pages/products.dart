import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;
  ProductsPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}
class _ProductsPageState extends State<ProductsPage>{
  @override
  initState(){
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon( model.displayFavoritesOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toogleDisplayMode();
              },
            );
          })
        ],
      ),
      body: Products(),
    );
  }
}
