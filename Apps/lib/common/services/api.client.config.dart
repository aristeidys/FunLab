import 'dart:io';

class Config {
  static String host = 'http://10.0.2.2:3000/';

  static Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        };
}
