import 'dart:convert';

import 'package:dw3_pizza_delivery_api/modules/users/controller/mappers/register_input_model_mapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

class UserController {
  @Route.post('/')
  Future<Response> register(Request request) async {
    final requestMap = jsonDecode(await request.readAsString());
    final inputModel = RegisterInputModelMapper(requestMap).mapper();

    return Response.ok(jsonEncode({'name': 'usuario'}));
  }

  Router get router => _$UserControllerRouter(this);
}
