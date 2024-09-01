import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/location_selection_page.dart';
import 'pages/login_page.dart';
import 'welcome_page.dart';

void main() async {
  // Initialize Hive before the app runs
  await Hive.initFlutter();

  // Ensure the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => WelcomePage(), // Welcome page as the initial screen
        '/login': (context) => LoginPage(), // Login page route
        '/location': (context) => LocationSelectionPage(), // Location selection page route
      },
    );
  }
}
