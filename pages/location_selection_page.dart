import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // LatLng type from latlong2 package
import '../my_buses_page.dart'; // Import the BusesPage
import '../welcome_page.dart'; // Import the WelcomePage
import 'ProfilePage.dart';  // Import the ProfilePage
import 'User.dart';
import 'bus_details_page.dart'; // Import your User model


class LocationSelectionPage extends StatefulWidget {
  final User user; // Add a User parameter

  const LocationSelectionPage({super.key, required this.user}); // Update constructor

  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  final List<String> _busStops = ['Stop 1', 'Stop 2', 'Stop 3']; // Example bus stops
  LatLng? _selectedLocation;
  bool _isLoading = false;
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();

  // Placeholder for South African bus stops
  final List<LatLng> _southAfricanBusStops = [
    LatLng(-26.2041, 28.0473),  // Johannesburg
    LatLng(-33.9249, 18.4241),  // Cape Town
    LatLng(-29.8587, 31.0218),  // Durban
    LatLng(-25.7479, 28.2293),  // Pretoria
    LatLng(-25.6836, 27.2395),  // Rustenburg
    LatLng(-28.6474, 21.1594),  // Upington
    LatLng(-23.9045, 29.4689),  // Polokwane
    LatLng(-26.5242, 31.4659),  // Mbombela (Nelspruit)
    LatLng(-34.0039, 23.0514),  // Knysna
    LatLng(-26.7759, 29.4634),  // Standerton
    LatLng(-33.5639, 25.4853),  // Gqeberha (Port Elizabeth)
    LatLng(-32.2968, 26.5225),  // Mthatha
    LatLng(-31.8976, 26.8571),  // Queenstown
    LatLng(-29.6644, 30.3936),  // Pietermaritzburg
    LatLng(-31.4201, 27.6035),  // Butterworth
    LatLng(-33.3003, 26.5323),  // Grahamstown (Makhanda)
    LatLng(-30.7195, 26.4743),  // Aliwal North
    LatLng(-28.7811, 31.8994),  // Richards Bay
    LatLng(-33.4015, 22.2040),  // Oudtshoorn
    LatLng(-28.7654, 24.7690),  // Kimberley
    LatLng(-29.1446, 26.1596),  // Bloemfontein
    LatLng(-23.8816, 30.3156),  // Tzaneen
    LatLng(-27.6574, 26.5156),  // Kroonstad
    LatLng(-27.6493, 27.2349),  // Potchefstroom
    LatLng(-26.1651, 27.7069),  // Krugersdorp
    LatLng(-27.9836, 26.7319),  // Welkom
    LatLng(-25.9605, 29.2407),  // Witbank (Emalahleni)
    LatLng(-31.6015, 28.7746),  // East London
    LatLng(-33.0182, 27.9116),  // King William’s Town
  ];

  // Navigate to the bus stop page with the selected bus stop
  void _navigateToBusStop(String busStop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBusesPage(busStop: busStop),
      ),
    );
  }

  // Navigate to the profile page
  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(user: widget.user), // Pass the user here
      ),
    );
  }

  // Navigate to the welcome page
  void _navigateToWelcomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
    );
  }

  // Logout functionality
  void _logout() {
    // Implement your logout logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()), // Assuming WelcomePage is the login screen
    );
  }

  // Function to handle map taps and select location
  void _onMapTap(LatLng latlng) {
    setState(() {
      _selectedLocation = latlng;
    });
  }

  // Function to search buses between 'from' and 'to' locations
  void _searchBuses() {
    String from = _fromController.text;
    String to = _toController.text;

    if (from.isEmpty || to.isEmpty || _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both From and To locations and select a stop')),
      );
      return;
    }

    // Navigate to BusDetailsPage with coordinates
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusDetailsPage(
          fromLocation: from,
          toLocation: to,
          fromCoordinates: _southAfricanBusStops.first, // Replace with the actual starting coordinates
          toCoordinates: _selectedLocation!, // Pass selected location as toCoordinates
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // "From" and "To" search bars with an arrow in between
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward, size: 24),
                ),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-30.5595, 22.9375), // Center of South Africa
                zoom: 5.0,
                onTap: (tapPosition, latlng) => _onMapTap(latlng), // Handle map taps
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _southAfricanBusStops.map((busStop) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: busStop,
                      builder: (ctx) => const Icon(
                        Icons.bus_alert,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _selectedLocation!,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (_selectedLocation != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected Location: (${_selectedLocation!.latitude}, ${_selectedLocation!.longitude})',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ElevatedButton(
            onPressed: _searchBuses, // Search based on "From" and "To" fields
            child: const Text('Search Buses'),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            )
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
