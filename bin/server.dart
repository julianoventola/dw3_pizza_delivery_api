import 'dart:io';

import 'package:args/args.dart';
import 'package:dw3_pizza_delivery_api/application/config/database_connection_configuration.dart';
import 'package:dw3_pizza_delivery_api/application/middlewares/middlewares.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

import 'package:dotenv/dotenv.dart' show load, env;

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(cors())
      .addMiddleware(defaultContentType('application/json;charset=utf-8'))
      .addHandler(_echoRequest);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) =>
    shelf.Response.ok('Request for "${request.url}"');

Future<void> loadConfigApplication() async {
  await load(); // Load dotenv variables

  // Creates database connection config - [ mysql docker]
  final databaseConfig = DatabaseConnectionConfiguration(
    host: Platform.environment['DATABASE_HOST'] ?? env['databaseHost'],
    user: Platform.environment['DATABASE_USER'] ?? env['databaseUser'],
    port: Platform.environment['DATABASE_PORT'] ?? env['databasePort'],
    password:
        Platform.environment['DATABASE_PASSWORD'] ?? env['databasePassword'],
    databaseName: Platform.environment['DATABASE_NAME'] ?? env['databaseName'],
  );

  // Creates a singleton for the connection
  GetIt.I.registerSingleton(databaseConfig);
}
