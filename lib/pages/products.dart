import 'package:firstapp/widgets/ui_elements/adaptive_progress_indicator.dart';
import 'package:firstapp/widgets/ui_elements/logout_listtile.dart';
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

class _ProductsPageState extends State<ProductsPage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("चुनें"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("उत्पाद का प्रबंधन करें"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(
            color: Colors.grey,
            height: 2,
          ),
          LogoutListTile(),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text("No product please add one !!"));
      if (model.dislpayedProducts.length > 0 && !model.isLoading)
        content = Products();
      else if (model.isLoading)
        content = Center(child: AdaptiveProgressIndicator());
      return RefreshIndicator(
        onRefresh: model.fetchProducts,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('बाजार'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.displayFavoritesOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toogleDisplayMode();
              },
            );
          })
        ],
      ),
      body: _buildProductList(),
    );
  }
}
