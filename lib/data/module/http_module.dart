import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpModule {
  @singleton
  Client get client => Client();
}
