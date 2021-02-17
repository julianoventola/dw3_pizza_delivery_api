import 'package:dw3_pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:dw3_pizza_delivery_api/application/entities/menu_item.dart';
import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/application/entities/order_item.dart';
import 'package:dw3_pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:dw3_pizza_delivery_api/modules/orders/view_models/save_order_input_model.dart';
import 'package:dw3_pizza_delivery_api/repositories/order/i_order_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  final IDatabaseConnection _connection;

  OrderRepository(this._connection);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    final conn = await _connection.openConnection();
    try {
      await conn.transaction((_) async {
        final result = await conn.query(
          'insert into pedido(id_usuario,forma_pagamento, endereco_entrega) values(?,?,?)',
          [saveOrder.userId, saveOrder.paymentType, saveOrder.address],
        );

        final orderId = result.insertId;
        await conn.queryMulti(
          'insert into pedido_item(id_pedido ,id_cardapio_grupo_item) values(?,?)',
          saveOrder.itemsId.map((item) => [orderId, item]),
        );
      });
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(
        message: 'Erro ao registrar pedido',
        exception: '',
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    final conn = await _connection.openConnection();
    final orders = <Order>[];
    try {
      final ordersResult = await conn.query(
        'select * from pedido where id_usuario = ?',
        [userId],
      );

      if (ordersResult.isNotEmpty) {
        for (var pedido in ordersResult) {
          final orderData = pedido.fields;
          final orderItemsResult = await conn.query(
            '''
            select 
              p.id_pedido_item, item.id_cardapio_grupo_item, item.nome, item.valor
            from pedido_item p inner join cardapio_grupo_item item 
            on item.id_cardapio_grupo_item = p.id_cardapio_grupo_item 
            where p.id_pedido = ?
            ''',
            [orderData['id_pedido']],
          );

          final items = orderItemsResult.map<OrderItem>((item) {
            final itemFields = item.fields;
            return OrderItem(
                itemFields['id_pedido_item'],
                MenuItem(
                  id: itemFields['id_cardapio_grupo_item'] as int,
                  name: itemFields['nome'],
                  price: itemFields['valor'],
                ));
          }).toList();

          final order = Order(
            orderData['id_pedido'] as int,
            orderData['forma_pagamento'] as String,
            (orderData['endereco_entrega'] as Blob).toString(),
            items,
          );
          orders.add(order);
        }
      }
      return orders;
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(
        message: 'Erro ao buscar pedidos',
        exception: '',
      );
    } finally {
      await conn?.close();
    }
  }
}
