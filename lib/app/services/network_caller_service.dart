import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/modules/auth/views/auth_view.dart';
import 'package:newproject/app/services/logger_model.dart';
import 'package:newproject/app/services/network_response_model.dart';

class NetworkCallerService {
  final Map<String, String>? headers;

  NetworkCallerService({required this.headers});

  Future<NetworkResponseModel> _request({
    required String method,
    required String uri,
    Map<String, dynamic>? body,
    bool isRetry = false,
    bool isAuthRequired = true,
  }) async {
    try {
      final request = Request(method, Uri.parse(uri));

      request.headers.addAll(headers ?? {});

      if (await AuthPrefsService().getToken() != null) {
        request.headers.addAll({
          'Authorization': 'Bearer ${await AuthPrefsService().getToken()}',
        });
      }

      if (body != null) {
        request.body = jsonEncode(body);
      }

      LoggerModel(url: uri, statusCode: 0, body: request.body).printLog();

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
      );

      final response = await Response.fromStream(streamedResponse);

      final isSuccess = [200, 201, 202, 204].contains(response.statusCode);

      if (isAuthRequired) {
        if (response.statusCode == 401 && !isRetry) {
          bool isRefreshSuccess = await _refreshToken();
          if (isRefreshSuccess) {
            return _request(
              method: method,
              uri: uri,
              body: body,
              isRetry: true,
            );
          }
        }
        if (response.statusCode == 401) {
          await AuthPrefsService().removeToken();
          Get.offAll(AuthView());
          // Navigator.pushNamedAndRemoveUntil(
          //   BlackLandCesRy.navigatorKey.currentContext!,
          //   LoginScreen.name,
          //   (route) => false,
          // );
        }
      }

      dynamic decodedBody;
      try {
        decodedBody = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
      } catch (_) {
        decodedBody = response.body;
      }

      LoggerModel(
        url: uri,
        statusCode: response.statusCode,
        body: response.body,
      ).printLog(isError: !isSuccess);

      return NetworkResponseModel(
        isSuccess: isSuccess,
        statusCode: response.statusCode,
        responseData: decodedBody,
        message: null,
      );
    } catch (e) {
      LoggerModel(
        url: uri,
        statusCode: -1,
        body: e.toString(),
      ).printLog(isError: true);

      return NetworkResponseModel(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        message: e.toString(),
      );
    }
  }

  //GENERATE REFRESH TOKEN
  Future<bool> _refreshToken() async {
    try {
      final request = Request('POST', Uri.parse('REFRESH_URL'));

      request.headers.addAll({'Content-Type': 'application/json'});

      request.body = jsonEncode({
        "refresh_token": await AuthPrefsService().getRefreshToken(),
      });

      final streamedResponse = await request.send();
      final response = await Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await AuthPrefsService().saveToken(data['token']);
        await AuthPrefsService().saveRefreshToken(data['refreshToken']);

        return true;
      }
    } catch (_) {}

    return false;
  }

  /// OPERATIONS
  ///
  //
  Future<NetworkResponseModel> getCall(String uri) {
    return _request(method: 'GET', uri: uri);
  }

  Future<NetworkResponseModel> postCall(
    String uri,
    Map<String, dynamic> body,
    bool isAuthRequired,
  ) {
    return _request(
      method: 'POST',
      uri: uri,
      body: body,
      isAuthRequired: isAuthRequired,
    );
  }

  Future<NetworkResponseModel> patchCall(
    String uri,
    Map<String, dynamic> body,
  ) {
    return _request(method: 'PATCH', uri: uri, body: body);
  }

  Future<NetworkResponseModel> deleteCall(
    String uri,
    Map<String, dynamic>? body,
  ) {
    return _request(method: 'DELETE', uri: uri, body: body);
  }
}
