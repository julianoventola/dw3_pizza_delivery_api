import 'package:dw3_pizza_delivery_api/application/routes/i_router_configure.dart';
import 'package:dw3_pizza_delivery_api/modules/users/controller/user_controller.dart';

import 'package:shelf_router/src/router.dart';

class UsersRouter implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.mount('/user/', UserController().router);
  }
}
