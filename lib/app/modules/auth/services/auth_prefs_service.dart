import 'dart:convert';

import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefsService {
  AuthPrefsService._();
  static final AuthPrefsService _instance = AuthPrefsService._();
  factory AuthPrefsService() => _instance;

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<bool> saveToken(String token) async {
    final prefs = await this.prefs;
    return prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await this.prefs;
    return prefs.getString('token');
  }

  Future<bool> saveRefreshToken(String token) async {
    final prefs = await this.prefs;
    return prefs.setString('refreshToken', token);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await this.prefs;
    return prefs.getString('refreshToken');
  }

  Future<void> removeToken() async {
    final prefs = await this.prefs;
    prefs.remove('token');
    prefs.remove('refreshToken');
  }

  Future<void> saveUser(LoginResponseModel body) async {
    final prefs = await this.prefs;
    prefs.setString('user', jsonEncode(body.toJson()));
  }

  Future<LoginResponseModel?> getUser() async {
    final prefs = await this.prefs;
    final user = prefs.getString('user');
    return user != null ? LoginResponseModel.fromJson(jsonDecode(user)) : null;
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    final prefs = await this.prefs;
    prefs.setBool('rememberMe', rememberMe);
  }

  Future<bool> getRememberMe() async {
    final prefs = await this.prefs;
    return prefs.getBool('rememberMe') ?? false;
  }
}
