import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/User.dart'; // Ensure this path is correct
import 'pages/login_page.dart'; // Import for login page
import 'register_page.dart'; // Import for registration page
import 'welcome_page.dart'; // Import for welcome page
import 'pages/location_selection_page.dart'; // Import for location selection page

void main() async {
  // Initialize Hive before the app runs
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome', // Set the initial route to the welcome page
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) {
          // Handle potential null value safely
          final User? user = ModalRoute.of(context)?.settings.arguments as User?;
          if (user == null) {
            // Handle null user case (e.g., navigate to login)
            Navigator.pushReplacementNamed(context, '/login');
            return const SizedBox.shrink(); // Return an empty widget
          }
          return HomePage(user: user); // Pass User object to HomePage
        },
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final User user; // Accept User object

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.username}!'), // Display username
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToLocationSelectionPage(context, user); // Navigate with user
              },
              child: const Text('Go to Location Selection'),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to navigate to the LocationSelectionPage with User
void navigateToLocationSelectionPage(BuildContext context, User user) async {
  // Open the Hive box and save the user data
  var box = await Hive.openBox('userBox');
  await box.put('exampleUser', {
    'username': user.username,
    'password': user.password,
  });

  // Navigate to the LocationSelectionPage
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LocationSelectionPage(user: user), // Ensure LocationSelectionPage accepts user
    ),
  );
}
