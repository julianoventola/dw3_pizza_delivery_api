import 'package:dw3_pizza_delivery_api/application/helpers/cripty_helper.dart';
import 'package:dw3_pizza_delivery_api/modules/users/view_models/register_input_model.dart';
import 'package:dw3_pizza_delivery_api/repositories/user/i_user_repository.dart';
import 'package:dw3_pizza_delivery_api/services/user/i_user_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  final IUserRepository _repository;

  UserService(
    this._repository,
  );

  @override
  Future<void> register(RegisterInputModel inputModel) async {
    final passwordCrypt = CriptyHelper.generateSHA256Hash(inputModel.password);
    inputModel.password = passwordCrypt;
    await _repository.saveUser(inputModel);
  }
}
