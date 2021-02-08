import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'database_connection_configuration.dart';
import '../database/database_connection.dart';
import '../database/i_database_connection.dart';

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<IDatabaseConnection>(
      () => DatabaseConnection(get<DatabaseConnectionConfiguration>()));
  return get;
}
