import 'dart:convert';

import 'package:dishcover_client/exceptions/http_bad_request_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:recase/recase.dart';

class Api {
  Uri _getUri({
    required String path,
  }) {
    return Uri(
      host: 'localhost',
      path: 'api/$path',
      port: 80,
      scheme: 'http',
    );
  }

  Future<Map<String, dynamic>> postForm({
    required String path,
    required Uint8List? fileBytes,
  }) async {
    final req = http.MultipartRequest('POST', _getUri(path: path));

    if (fileBytes != null) {
      req.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          contentType: http_parser.MediaType('image', 'jpeg'),
          filename: 'img',
        ),
      );
    }

    return _fixMapCase(
      input: jsonDecode(await _validate(response: await req.send())),
    );
  }

  Future<String> _validate({
    required http.StreamedResponse response,
  }) async {
    final body = await response.stream.bytesToString();

    if (kDebugMode) {
      print(response.request.toString());
      print(body);
    }

    if (response.statusCode >= 400) {
      throw HttpBadRequestException(message: body);
    }

    return body;
  }

  dynamic _fixMapCase({
    required dynamic input,
  }) {
    if (input is Map) {
      final temp = <String, dynamic>{};

      for (var element in input.entries) {
        temp[ReCase(element.key).camelCase] = _fixMapCase(input: element.value);
      }

      return temp;
    } else if (input is List) {
      final temp = <dynamic>[];

      for (var element in input) {
        temp.add(_fixMapCase(input: element));
      }

      return temp;
    }

    return input;
  }
}
