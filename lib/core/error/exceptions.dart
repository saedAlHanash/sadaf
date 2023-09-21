import 'package:http/http.dart';

class ServerException implements Exception {

final Response errorBody;

  ServerException(this.errorBody);
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
