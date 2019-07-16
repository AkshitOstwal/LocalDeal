import 'package:firstapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
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

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter Tilte of Product',
      ),
      initialValue: product == null ? null : product.title,
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

  Widget _buildDescriptionTeftField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Enter Description of product',
      ),
      onSaved: (String value) {
        _formData['description'] = value;
      },
      initialValue: product == null ? null : product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return "Description is required and should be 10+ character";
        }
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price',
        hintText: 'Enter Price',
      ),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      initialValue: product == null ? null : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return "Price is required and should be a number";
        }
      },
      keyboardType: TextInputType.number,
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, int selectedProductIndex) {
    if (!_formKey.currentState.validate()) return null;
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
        ),
      );
    } else {
      updateProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
        ),
      );
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Save'),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          onPressed: () => _submitForm(model.addProduct, model.updateProduct,
              model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
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
              _buildTitleTextField(product),
              _buildDescriptionTeftField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 15,
              ),
              _buildSubmitButton(),
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
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
