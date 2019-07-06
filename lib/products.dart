import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products) {
    print('[Product Widget ] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          //title
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  products[index]['title'],
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                //price
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    '₹ ${products[index]['price'].toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          //location
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('Jaipur ,Rajasthan'),
          ),
          //details button
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
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
