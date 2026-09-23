import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  /// Initializes Firebase if configuration is present.
  /// If config files are missing (prior to user provisioning),
  /// fails gracefully to allow UI preview, tests, and mock mode.
  static Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // Web requires options if used
        _isInitialized = false;
        return;
      }

      await Firebase.initializeApp();
      _isInitialized = true;
      developer.log('Firebase initialized successfully', name: 'FirebaseService');
    } catch (e, stack) {
      _isInitialized = false;
      developer.log(
        'Firebase initialization skipped or failed (config pending): $e',
        name: 'FirebaseService',
        error: e,
        stackTrace: stack,
      );
    }
  }
}
