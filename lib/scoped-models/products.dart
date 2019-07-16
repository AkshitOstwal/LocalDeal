import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex ;

  //we are returning a cop yf original list here
  // so that noone can add product without using our addProduct method
  List<Product> get products {
    return List.from(_products);
  }
  //since there are no such methods by which we can change te value of int so we dont need to return a copy of it,
  // we can return the index itself
  int get selectedProductIndex {
    return _selectedProductIndex;
  }
  
  Product get selectedProduct {
    if ( _selectedProductIndex == null){return null;}
    return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void selectProudct(int index) {
    _selectedProductIndex = index;
  }
}
