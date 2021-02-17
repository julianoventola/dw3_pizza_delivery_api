import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/modules/orders/view_models/save_order_input_model.dart';
import 'package:dw3_pizza_delivery_api/repositories/order/i_order_repository.dart';
import 'package:dw3_pizza_delivery_api/services/orders/i_order_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderService)
class OrderService implements IOrderService {
  final IOrderRepository _repository;

  OrderService(this._repository);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    await _repository.saveOrder(saveOrder);
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    return await _repository.findMyOrders(userId);
  }
}
