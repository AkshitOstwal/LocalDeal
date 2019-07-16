import '../models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User _authenticatedUser;
  
  void login(String email, String password) {
    _authenticatedUser = User(id: '00001', email: email, password: password);
  }
}
