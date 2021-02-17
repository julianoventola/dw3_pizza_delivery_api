// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$OrderControllerRouter(OrderController service) {
  final router = Router();
  router.add('POST', r'/', service.saveOrder);
  router.add('GET', r'/user/<userId>', service.find);
  return router;
}
