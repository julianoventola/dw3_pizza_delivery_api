part of 'user_controller.dart';

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add('GET', r'/', service.hello);
  return router;
}
