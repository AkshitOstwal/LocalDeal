import 'dart:io';

import 'package:firstapp/models/product.dart';
import 'package:firstapp/widgets/form_inputs/image.dart';
import 'package:firstapp/widgets/ui_elements/adaptive_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
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
    'image': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _priceTextController = TextEditingController();

  Widget _buildTitleTextField(Product product) {
    if (product == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (product != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = product.title;
    } else if (product != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (product == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'शीर्षक',
        hintText: 'शीर्षक',
      ),
      controller: _titleTextController,
      // initialValue: product == null ? null : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return "शीर्षक आवश्यक है";
        }
        return null;
      },
      onSaved: (String value) {
        _formData['title'] = _titleTextController.text;
      },
    );
  }

  Widget _buildDescriptionTeftField(Product product) {
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    } else if (product != null &&
        _descriptionTextController.text.trim() != '') {
      _descriptionTextController.text = _descriptionTextController.text;
    } else if (product == null &&
        _descriptionTextController.text.trim() != '') {
      _descriptionTextController.text = _descriptionTextController.text;
    } else {
      _descriptionTextController.text = '';
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'विवरण',
        hintText: 'विवरण',
      ),
      controller: _descriptionTextController,
      onSaved: (String value) {
        _formData['description'] = _descriptionTextController.text;
      },
      // initialValue: product == null ? null : product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return "विवरण आवश्यक है";
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }

  Widget _buildPriceTextField(Product product) {
    if (product == null && _priceTextController.text.trim() == '') {
      _priceTextController.text = '';
    } else if (product != null && _priceTextController.text.trim() == '') {
      _priceTextController.text = product.price.toString();
    } else if (product != null && _priceTextController.text.trim() != '') {
      _priceTextController.text = _priceTextController.text;
    } else if (product == null && _priceTextController.text.trim() != '') {
      _priceTextController.text = _priceTextController.text;
    } else {
      _priceTextController.text = '';
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'मूल्य',
        hintText: 'मूल्य',
      ),
      controller: _priceTextController,

      // initialValue: product == null ? null : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
          return "मूल्य  आवश्यक है";
        }
        return null;
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: AdaptiveProgressIndicator())
            : RaisedButton(
                child: Text('सुरक्षित करें'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectedProductIndex,
                    model.selectProduct),
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
              ImageInput(_setImage, product),
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

  void _setImage(File image) {
    _formData['image'] = image;
  }

  void _submitForm(Function addProduct, Function updateProduct,
      int selectedProductIndex, Function setSelectedProduct) {
    if (!_formKey.currentState.validate() ||
        (_formData['image'] == null && selectedProductIndex == -1)) return null;
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
        _titleTextController.text,
        _descriptionTextController.text,
        _formData['image'],
        double.parse(_priceTextController.text.replaceFirst(RegExp(r','), '.')),
      ).then((bool success) {
        success
            ? Navigator.pushReplacementNamed(context, '/products')
                .then((_) => setSelectedProduct(null))
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('कुछ गड़बड़ है!'),
                    content: Text('बाद में पुन: प्रयास करें'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("ठीक"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              );
      });
    } else {
      updateProduct(
        _titleTextController.text,
        _descriptionTextController.text,
        _formData['image'],
        double.parse(_priceTextController.text.replaceFirst(RegExp(r','), '.')),
      ).then((bool success) {
        success
            ? Navigator.pushReplacementNamed(context, '/products')
                .then((_) => setSelectedProduct(null))
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('कुछ गड़बड़ है!!!'),
                    content: Text('बाद में पुन: प्रयास करें'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("ठीक"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('उत्पाद संपादित करें'),
                  elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
                ),
                body: pageContent,
              );
      },
    );
  }
}
