import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];

  List<Product> get products{
    return List.from(_products);
  }

  void addProduct(Product product) {
    //creatring this so we can access the setState in product_control
    _products.add(product);
  }

  void updateProduct(int index, Product product) {
    _products[index] = product;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }
}
