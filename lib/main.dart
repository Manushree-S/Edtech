import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (fails gracefully if credentials/google-services.json pending)
  await FirebaseService.initialize();

  runApp(
    const ProviderScope(
      child: EdTechApp(),
    ),
  );
}
