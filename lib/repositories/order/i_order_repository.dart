import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/modules/orders/view_models/save_order_input_model.dart';

abstract class IOrderRepository {
  Future<void> saveOrder(SaveOrderInputModel saveOrder);
  Future<List<Order>> findMyOrders(int userId);
}
