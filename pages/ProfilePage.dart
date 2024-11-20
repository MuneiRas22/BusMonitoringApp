// lib/pages/ProfilePage.dart
import 'package:flutter/material.dart';
import 'FavoritesPage.dart';
import 'FollowUsOnPage.dart';
import 'HelpSupportPage.dart';
import 'MyTicketsPage.dart';
import 'OffersPage.dart';
import 'PaymentHistoryPage.dart';
import 'ReferLearnPage.dart';
import 'RewardsPage.dart';
import 'SettingsPage.dart';
import 'WalletPage.dart';
import 'User.dart'; // Importing the User model

class ProfilePage extends StatelessWidget {
  final User user;  // Accept the user as a parameter

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          // Display the username at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello, ${user.username}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),  // Optional divider

          // Profile options
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My Tickets'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTicketsPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentHistoryPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
            title: const Text('Rewards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RewardsPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Offers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OffersPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Wallet'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Refer & Learn'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReferLearnPage(user: user)), // Note the lowercase 'user'
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help and Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Share with Friends'),
            onTap: () {
              // Implement sharing functionality here
            },
          ),
          ListTile(
            leading: const Icon(Icons.follow_the_signs),
            title: const Text('Follow Us On'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FollowUsOnPage(user: user)),
              );
            },
          ),
        ],
      ),
    );
  }
}
