import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';

class OTPPage extends StatelessWidget {
  OTPPage({super.key});

  // text editing controller
  final otpController = TextEditingController();

  // verify OTP method
  void verifyOTP(BuildContext context) {
    // Here you would typically verify the OTP with your backend
    // If successful, navigate to the next page or main application
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
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.bus_alert,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // OTP textfield
                MyTextField(
                  controller: otpController,
                  hintText: 'Enter OTP',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // verify button
                MyButton(
                  onTap: () => verifyOTP(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
