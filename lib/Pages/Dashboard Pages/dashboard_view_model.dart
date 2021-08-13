import 'package:flutter/foundation.dart';
import 'package:untitled/services/secure_storage_service.dart';

class DashboardViewModel extends ChangeNotifier {
  final SecureStorageService secureStorageService;

  DashboardViewModel(
      this.secureStorageService,
      );

  Future<void> signOut() {
    return secureStorageService.deleteAll();
  }
}