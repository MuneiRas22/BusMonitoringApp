import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import '../my_buses_page.dart'; // Import the BusesPage
import '../welcome_page.dart'; // Import the WelcomePage
import 'ProfilePage.dart';  // Import the ProfilePage

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  final TextEditingController _fromLocationController = TextEditingController();
  final TextEditingController _toLocationController = TextEditingController();
  final String googleApiKey = 'YOUR_GOOGLE_API_KEY'; // Replace with your API key

  List<String> _busStops = ['Stop 1', 'Stop 2', 'Stop 3'];
  bool _isLoading = false;

  Future<void> _handlePressButton(TextEditingController controller) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "za")],
    );

    if (p != null) {
      setState(() {
        controller.text = p.description!;
      });
    }
  }

  void _searchBusStops() {
    setState(() {
      _isLoading = true;
      // Simulate network request or API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  void _navigateToBusStop(String busStop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBusesPage(busStop: busStop),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void _navigateToWelcomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
    );
  }

  void _logout() {
    // Implement your logout logic here
    // For example, navigate to the login page or clear user session
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()), // Assuming WelcomePage is the login screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // "From" location input field with Google Places
            TextField(
              controller: _fromLocationController,
              readOnly: true,
              onTap: () => _handlePressButton(_fromLocationController),
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
                suffixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            // "To" location input field with Google Places
            TextField(
              controller: _toLocationController,
              readOnly: true,
              onTap: () => _handlePressButton(_toLocationController),
              decoration: InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
                suffixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchBusStops,
              child: const Text('Search Bus Stops'),
            ),
            const SizedBox(height: 16),
            // Display loading indicator
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _busStops.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.bus_alert),
                      title: Text(_busStops[index]),
                      onTap: () => _navigateToBusStop(_busStops[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 28),
              onPressed: _navigateToWelcomePage,
              tooltip: 'Home',
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 28),
              onPressed: _navigateToProfile,
              tooltip: 'Profile',
            ),
            IconButton(
              icon: const Icon(Icons.logout, size: 28),
              onPressed: _logout,
              tooltip: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
