// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../database/database_connection.dart';
import 'database_connection_configuration.dart';
import '../database/i_database_connection.dart';
import '../../repositories/menu/i_menu_repository.dart';
import '../../services/menu/i_menu_service.dart';
import '../../repositories/order/i_order_repository.dart';
import '../../services/orders/i_order_service.dart';
import '../../repositories/user/i_user_repository.dart';
import '../../services/user/i_user_service.dart';
import '../../modules/menu/controller/menu_controller.dart';
import '../../repositories/menu/menu_repository.dart';
import '../../services/menu/menu_service.dart';
import '../../modules/orders/controllers/order_controller.dart';
import '../../repositories/order/order_repository.dart';
import '../../services/orders/order_service.dart';
import '../../modules/users/controller/user_controller.dart';
import '../../repositories/user/user_repository.dart';
import '../../services/user/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<IDatabaseConnection>(
      () => DatabaseConnection(get<DatabaseConnectionConfiguration>()));
  gh.lazySingleton<IMenuRepository>(
      () => MenuRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IMenuService>(() => MenuService(get<IMenuRepository>()));
  gh.lazySingleton<IOrderRepository>(
      () => OrderRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IOrderService>(() => OrderService(get<IOrderRepository>()));
  gh.lazySingleton<IUserRepository>(
      () => UserRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IUserService>(() => UserService(get<IUserRepository>()));
  gh.factory<MenuController>(() => MenuController(get<IMenuService>()));
  gh.factory<OrderController>(() => OrderController(get<IOrderService>()));
  gh.factory<UserController>(() => UserController(get<IUserService>()));
  return get;
}
