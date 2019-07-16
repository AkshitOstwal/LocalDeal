import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import './connected_products.dart';

class ProductsModel extends ConnectedProducts {
  
  bool _showFavorites = false;

  //we are returning a cop yf original list here
  // so that noone can add product without using our addProduct method
  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get dislpayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  //since there are no such methods by which we can change te value of int so we dont need to return a copy of it,
  // we can return the index itself
  int get selelctedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selProductIndex == null) {
      return null;
    }
    return products[selProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }


  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    products[selProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void toogleProductFavoriteStatus() {
    final bool isCurretlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurretlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus
        );
    products[selProductIndex] = updatedProduct;
    
    notifyListeners();
    selProductIndex = null;
  }

  



  void toogleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
