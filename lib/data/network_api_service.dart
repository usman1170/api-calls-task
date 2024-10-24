import 'dart:developer';

import 'package:api_calls/data/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkApiService implements BaseApiService {
  @override
  Future getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 20),
          );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('Error: ${response.statusCode}, Body: ${response.body}');
        return response.body;
      }
    } catch (e) {
      return e;
    }
  }

  @override
  Future postApi(String url, data) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(seconds: 20),
          );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('Error: ${response.statusCode}, Body: ${response.body}');
        return response.body;
      }
    } catch (e) {
      return e;
    }
  }
}
