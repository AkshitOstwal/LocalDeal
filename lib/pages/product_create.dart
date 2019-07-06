import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter Tilte of Product',
      ),
      validator: (String value){
        if ( value.isEmpty || value.length<5){
          return "Title is required and should be 5+ character";
        }
      },
      onSaved: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTeftField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Enter Description of product',
      ),
      onSaved: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
       validator: (String value){
        if ( value.isEmpty || value.length<10){
          return "Description is required and should be 10+ character";
        }
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price',
        hintText: 'Enter Price',
      ),
      onSaved: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
       validator: (String value){
        if ( value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)){
          return "Price is required and should be a number";
        }
      },
      keyboardType: TextInputType.number,
    );
  }

  void _submitForm() {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTeftField(),
            _buildPriceTextField(),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: _submitForm,
            ),
            // GestureDetector(
            //   child: Container(
            //     child: Text('My Button'),
            //     color: Colors.lightGreenAccent,
            //     padding: EdgeInsets.all(5),
            //   ),
            //   onTap: _submitForm,
            // )
          ],
        ),
      ),
    );
  }
}
