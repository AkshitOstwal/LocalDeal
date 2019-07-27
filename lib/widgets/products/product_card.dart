import 'package:firstapp/models/product.dart';
import 'package:firstapp/widgets/products/address_tag.dart';
import '../../scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  

  ProductCard(this.product,);
  //now we are using a particular index of list as an argument + the index also

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(child:TitleDefault(product.title)),
          Flexible(child:SizedBox(
            width: 8.0,
          )),
          //price
          Flexible(child:PriceTag(product.price.toString()))
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).accentColor,
              onPressed: () {
                model.selectProduct(product.id);
                Navigator.pushNamed<bool>(context,
                        '/product/' + product.id)
                    .then((_) {
                  model.selectProduct(null);
                });
              },
            ),
            IconButton(
              icon: Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(product.id);
                model.toogleProductFavoriteStatus();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Hero(tag: product.id,
            child: FadeInImage(
            image: NetworkImage(product.image),
            placeholder: AssetImage('assets/food.jpg'),
            height: 300,
            fit: BoxFit.cover,
          ),),
          //title
          _buildTitlePriceRow(),
          SizedBox(height: 10,),
          //location
          
          AddressTag('जयपुर, राजस्थान'),
          //action buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
