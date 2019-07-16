import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

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
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void toogleProductFavoriteStatus() {
    final bool isCurretlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurretlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus);
    _products[_selectedProductIndex] = updatedProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProudct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }
}
