import 'package:firstapp/pages/product_edit.dart';
import '../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductListPageState();
  }
}
class _ProductListPageState extends State <ProductListPage>{
  @override
  initState(){
    widget.model.fetchProducts(onlyForUser : true,clearExisting: true);
    super.initState();
  }
  Widget _bulidEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        ).then((_) {
          model.selectProduct(null);
        });
      },
    );
  }

  Widget _buildDeleteBackground() {
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
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.allProducts[index].title),
            background: _buildDeleteBackground(),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProduct(model.allProducts[index].id);
                model.deleteProduct();
              }
            },
            direction: DismissDirection.endToStart,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(model.allProducts[index].image),
                    radius: 25,
                  ),
                  title: Text(
                    model.allProducts[index].title,
                  ),
                  subtitle: Text('₹ ${model.allProducts[index].price}'),
                  trailing: _bulidEditButton(context, index, model),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
