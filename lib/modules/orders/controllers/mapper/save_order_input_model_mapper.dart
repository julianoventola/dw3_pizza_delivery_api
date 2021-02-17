import 'dart:convert';

import 'package:dw3_pizza_delivery_api/modules/orders/view_models/save_order_input_model.dart';

class SaveOrderInputModelMapper {
  final Map<String, dynamic> _data;

  SaveOrderInputModelMapper(String data) : _data = jsonDecode(data);

  SaveOrderInputModel mapper() {
    return SaveOrderInputModel(
      userId: _data['userId'],
      address: _data['address'],
      paymentType: _data['paymentType'],
      itemsId: List<int>.from(_data['itemsId']),
    );
  }
}
