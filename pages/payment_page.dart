import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String stopName;

  const PaymentPage({required this.stopName, super.key, required double price});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Prices for each stop in Rands
  final Map<String, double> stopPrices = {
    'Stop 1': 10.0,
    'Stop 2': 15.0,
    'Stop 3': 20.0,
    'Stop 4': 25.0,
    'Stop 5': 30.0,
  };

  String selectedStop = 'Stop 1'; // Default selected stop
  String selectedPaymentMethod = 'Ticket'; // Default payment method

  @override
  void initState() {
    super.initState();
    selectedStop = widget.stopName; // Set initial stop to the passed stop name
  }

  @override
  Widget build(BuildContext context) {
    double price = stopPrices[selectedStop]!; // Get price for the selected stop

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'End Trip at $selectedStop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedStop,
              items: stopPrices.keys.map((String stop) {
                return DropdownMenuItem<String>(
                  value: stop,
                  child: Text(stop),
                );
              }).toList(),
              onChanged: (String? newStop) {
                setState(() {
                  selectedStop = newStop!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: R${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              items: ['Ticket', 'Card'].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (String? newMethod) {
                setState(() {
                  selectedPaymentMethod = newMethod!;
                });
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle payment confirmation here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Confirmed using $selectedPaymentMethod!')),
                );
                // Navigate back or to another page
                Navigator.pop(context);
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
