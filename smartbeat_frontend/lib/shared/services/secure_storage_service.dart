import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartbeat_frontend/shared/models/info_app.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._privateConstructor();

  final storage = const FlutterSecureStorage();

  SecureStorageService._privateConstructor();

  static SecureStorageService get instance => _instance;

  Future<void> saveInfoEmpresa(InfoApp infoApp) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final infoJsonString = json.encode(infoApp.toMap());
    await storage.write(
        key: AppConstants.keyInfoApp, value: infoJsonString);
  }

  Future<InfoApp?> get infoApp async {
    final infoJsonString = await storage.read(key: AppConstants.keyInfoApp);
    if (infoJsonString != null) {
      final infoJsonData = json.decode(infoJsonString);
      return InfoApp.from(infoJsonData);
    }
    return null;
  }
}
