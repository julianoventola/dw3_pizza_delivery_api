import 'package:dw3_pizza_delivery_api/application/routes/i_router_configure.dart';
import 'package:dw3_pizza_delivery_api/modules/users/users_router.dart';

import 'package:shelf_router/src/router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouterConfigure> routers = [
    UsersRouter(),
  ];

  RouterConfigure(this._router);

  void configure() => routers.forEach((route) => route.configure(_router));
}
