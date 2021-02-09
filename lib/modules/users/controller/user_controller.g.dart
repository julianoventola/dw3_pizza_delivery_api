part of 'user_controller.dart';

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add('POST', r'/', service.register);
  return router;
}
