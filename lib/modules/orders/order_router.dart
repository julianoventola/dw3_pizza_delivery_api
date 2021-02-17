import 'package:dw3_pizza_delivery_api/application/routes/i_router_configure.dart';
import 'package:dw3_pizza_delivery_api/modules/orders/controllers/order_controller.dart';

import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class OrdersRouter implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.mount('/order/', GetIt.I.get<OrderController>().router);
  }
}
