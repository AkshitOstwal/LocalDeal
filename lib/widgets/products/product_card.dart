import 'package:firstapp/models/product.dart';
import 'package:firstapp/widgets/products/address_tag.dart';
import '../../scoped-models/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);
  //now we are using a particular index of list as an argument + the index also

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          //price
          PriceTag(product.price.toString())
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/product/' + productIndex.toString()),
        ),
        ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
          return IconButton(
            icon: Icon(
              model.products[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            color: Colors.red,
            onPressed: () {
              model.selectProudct(productIndex);
              model.toogleProductFavoriteStatus();
            },
          );
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          //title
          _buildTitlePriceRow(),
          //location
          AddressTag('Jaipur,rajasthan'),
          //action buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
