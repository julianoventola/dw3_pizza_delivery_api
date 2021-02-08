import 'dart:io';

import 'package:shelf/shelf.dart';

const _defaultCorsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
  'Access-Control-Allow-Headers':
      '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}',
};

Middleware cors({Map<String, String> headers = _defaultCorsHeaders}) {
  return (Handler innerHanlder) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response(HttpStatus.ok, headers: headers);
      }
      final mapHeaders = {...request?.headers, ...headers};
      final response = await innerHanlder(request.change(headers: mapHeaders));
      return response.change(headers: headers);
    };
  };
}
