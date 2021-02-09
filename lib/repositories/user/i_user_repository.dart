import 'package:dw3_pizza_delivery_api/modules/users/view_models/register_input_model.dart';

abstract class IUserRepository {
  Future<void> saveUser(RegisterInputModel model);
}
