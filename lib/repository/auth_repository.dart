import 'dart:developer';

import 'package:api_calls/data/network_api_service.dart';
import 'package:api_calls/data/services/hive_service.dart';
import 'package:api_calls/models/user_model.dart';
import 'package:api_calls/utils/helper.dart';

class ApiRepository {
  final _api = NetworkApiService();
  final _hiveService = HiveService();

  Future<UserModel> login(dynamic data) async {
    final res = await _api.postApi(loginUrl, data);

    log('Raw response: $res');

    if (res is Map<String, dynamic>) {
      final userData = UserModel.fromMap(res);
      final token = userData.refreshToken;
      _hiveService.storeToken(token);
      return userData;
    } else {
      log('Unexpected response format: $res');
      throw Exception('Failed to login, unexpected response format');
    }
  }
}
