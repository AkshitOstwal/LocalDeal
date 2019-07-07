import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  ProductEditPage({this.addProduct, this.updateProduct, this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter Tilte of Product',
      ),
      initialValue: widget.product == null ? null : widget.product['title'],
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return "Title is required and should be 5+ character";
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
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
        _formData['description'] = value;
      },
      initialValue:
          widget.product == null ? null : widget.product['description'],
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
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
        _formData['price'] = double.parse(value);
      },
      initialValue:
          widget.product == null ? null : widget.product['price'].toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return "Price is required and should be a number";
        }
      },
      keyboardType: TextInputType.number,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return null;
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
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
      ),
    );

    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
