import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../models/user.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  User authenticatedUser;
  int selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id,
    );
    products.add(newProduct);
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }
}
