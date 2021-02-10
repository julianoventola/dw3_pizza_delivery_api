import 'dart:async';
import 'dart:convert';

import 'package:dw3_pizza_delivery_api/services/menu/i_menu_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'menu_controller.g.dart';

@Injectable()
class MenuController {
  final IMenuService _menuService;

  MenuController(this._menuService);

  @Route.get('/')
  Future<Response> findAll(Request request) async {
    try {
      final menus = await _menuService.getAllMenus();
      return Response.ok(
          jsonEncode(menus?.map((menu) => menu.toMap())?.toList() ?? []));
    } catch (e) {
      print(e);
      return Response.internalServerError();
    }
  }

  Router get router => _$MenuControllerRouter(this);
}
