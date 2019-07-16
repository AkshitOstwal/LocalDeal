import 'package:firstapp/scoped-models/connected_products.dart';
import '../models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends ConnectedProducts {
 

  void login(String email, String password) {
    authenticatedUser = User(id: '00001', email: email, password: password);
  }
}
