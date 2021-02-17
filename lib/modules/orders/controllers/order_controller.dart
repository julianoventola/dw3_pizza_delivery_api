import 'dart:convert';

import 'package:dw3_pizza_delivery_api/modules/orders/controllers/mapper/save_order_input_model_mapper.dart';
import 'package:dw3_pizza_delivery_api/services/orders/i_order_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'order_controller.g.dart';

@Injectable()
class OrderController {
  final IOrderService _service;

  OrderController(this._service);

  @Route.post('/')
  Future<Response> saveOrder(Request request) async {
    try {
      final inputModel =
          SaveOrderInputModelMapper(await request.readAsString()).mapper();
      await _service.saveOrder(inputModel);
      return Response.ok('');
    } catch (e) {
      print(e);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao salvar order'}));
    }
  }

  @Route.get('/user/<userId>')
  Future<Response> find(Request request, String userId) async {
    try {
      final orders = await _service.findMyOrders(int.parse(userId));
      final orderResponse = orders.map((o) => o.toMap()).toList();
      return Response.ok(jsonEncode(orderResponse));
    } catch (e) {
      print(e);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao burcar ordens'}));
    }
  }

  Router get router => _$OrderControllerRouter(this);
}
