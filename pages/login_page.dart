import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'location_selection_page.dart';
import '../register_page.dart';
import 'User.dart'; // Make sure to import your User model

// Custom MyButton Widget
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const MyButton({
    required this.onTap,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// LoginPage Widget
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign user in method
  Future<void> signUserIn(BuildContext context) async {
    try {
      // Open the Hive box
      var box = await Hive.openBox('userBox');
      var userData = box.get(usernameController.text);

      if (userData != null) {
        // Check if the entered password matches the one stored in the Hive box
        if (userData['password'] == passwordController.text) {
          // Create a User object with the correct password
          User user = User(
            username: userData['name'], // Use the stored username (or name)
            password: userData['password'], // Use the stored password
          );

          // Navigate to the location selection page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LocationSelectionPage(user: user), // Pass the User object here
            ),
          );
        } else {
          // Show an error if the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password')),
          );
        }
      } else {
        // Show an error if the user is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      // Show an error if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome text
                const Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                // Username text field
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Password text field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Sign in button
                MyButton(
                  onTap: () => signUserIn(context),
                  text: 'Sign In',
                ),

                const SizedBox(height: 25),

                // Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
