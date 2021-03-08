import 'package:bytebank/http/interceptors/interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

final String urlBase = 'http://192.168.1.105:8080/transactions';




