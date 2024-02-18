import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main()  {
  /*
var db = FirebaseFirestore.instance;
final city = <String, String>{
  "name": "Los Angeles",
  "state": "CA",
  "country": "USA"
};

db
    .collection("cities")
    .doc("LA")
    .set(city)
    .onError((e, _) => print("Error writing document: $e"));*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationScreen(),
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _schoolIdController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  bool _isSignUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? 'Sign Up' : 'Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _schoolIdController,
              decoration: InputDecoration(labelText: 'School ID'),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_isSignUp) ...[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isSignUp) {
                  // Handle sign up logic
                  _handleSignUp();
                } else {
                  // Handle log in logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Text(_isSignUp ? 'Sign Up' : 'Log In'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                });
              },
              child: Text(_isSignUp ? 'Already have an account? Log in' : 'Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignUp() {
    // Handle sign up logic
    // Code for sign up logic goes here
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Events'),
              Tab(text: 'Profile'),
              Tab(text: 'UMB_Events'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              // Home Tab
              HomeTabContent(),
              // Tab 2
             SearchTabContent(),
              // Tab 3
              ProfileTab(),
              UMB_EventsTabContent(),
              ProfileTabContent(),
              
            ],
          ),
      ),
    );
  }
}
class HomeTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Home Tab Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter some text...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showDurationDialog(context);
              },
              child: Text('Button Inside Home Tab'),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Upcoming Events',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text('Event 1'),
          subtitle: Text('Date: February 20, 2024'),
          trailing: Icon(Icons.event),
          onTap: () {
            // Handle tap on event
          },
        ),
        ListTile(
          title: Text('Event 2'),
          subtitle: Text('Date: February 25, 2024'),
          trailing: Icon(Icons.event),
          onTap: () {
            // Handle tap on event
          },
        ),
        // Add more ListTile widgets for additional events as needed
      ],
    );
  }

  void _showDurationDialog(BuildContext context) {
    // Dialog implementation remains the same
  }
}
class ProfileTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile Tab Content',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Add profile information here, such as user name, email, etc.
          ProfileInfoField(label: 'Name', value: 'John Doe'),
          ProfileInfoField(label: 'Email', value: 'john.doe@example.com'),
          // Add more profile information fields as needed
        ],
      ),
    );
  }
}

class Event {
  String details;
  int counter;

  Event(this.details, {this.counter = 0});
}

class UMB_EventsTabContent extends StatefulWidget {
  @override
  _UMB_EventsTabContentState createState() => _UMB_EventsTabContentState();
}

class _UMB_EventsTabContentState extends State<UMB_EventsTabContent> {
  List<Event> events = []; // List to store events

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController textAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              labelText: 'Type',
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: textAreaController,
            decoration: InputDecoration(
              labelText: 'Text Area',
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(),
            ),
            minLines: 3,
            maxLines: 5,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Implement functionality for button 1
            },
            child: Text('Save'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Add event to the list
                events.add(Event(_createEventString()));
                // Clear text field controllers
                nameController.clear();
                addressController.clear();
                typeController.clear();
                descriptionController.clear();
                textAreaController.clear();
              });
            },
            child: Text('Post'),
          ),
          SizedBox(height: 16),
          Text(
            'List of Events:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(
                  children: [
                    Text(events[index].details),
                    SizedBox(width: 10),
                    Text('Counter: ${events[index].counter}'),
                  ],
                ),
                subtitle: Text('Event details'),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Increment counter when "Join" button is pressed
                      events[index].counter++;
                    });
                  },
                  child: Text('Join'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to create a string representation of the event
  String _createEventString() {
    String name = nameController.text.isNotEmpty ? nameController.text : 'Unnamed Event';
    String address = addressController.text.isNotEmpty ? addressController.text : 'No Address';
    String type = typeController.text.isNotEmpty ? typeController.text : 'No Type';
    String description = descriptionController.text.isNotEmpty ? descriptionController.text : 'No Description';
    String textArea = textAreaController.text.isNotEmpty ? textAreaController.text : 'No Text';
    return 'Name: $name, Address: $address, Type: $type, Description: $description, Text Area: $textArea';
  }
}

class ProfileInfoField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoField({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SearchTabContent extends StatefulWidget {
  @override
  _SearchTabContentState createState() => _SearchTabContentState();
}

class _SearchTabContentState extends State<SearchTabContent> {
  List<String> _selectedCategories1 = []; // For the first dropdown
  List<String> _selectedCategories2 = []; // For the second dropdown
  List<List<String>> _randomItems = [];

  List<String> _categories1 = ['Football', 'Basketball', 'Baseball', 'Hockey'];
  List<String> _categories2 = ['Concert', 'Shows', 'Game'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Dropdown
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            value: _selectedCategories1.isNotEmpty ? _selectedCategories1 : null,
            onChanged: (dynamic value) {
              setState(() {
                _selectedCategories1 = List<String>.from(value as List<dynamic>);
              });
            },
            items: _categories1.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            isExpanded: true,
            // Enable multiple selection
            isDense: true,
            iconSize: 30,
            elevation: 16,
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.blue,
            dropdownColor: Colors.white,
          ),
        ),

        // Second Dropdown
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Event advertiser',
              border: OutlineInputBorder(),
            ),
            value: _selectedCategories2.isNotEmpty ? _selectedCategories2 : null,
            onChanged: (dynamic value) {
              setState(() {
                _selectedCategories2 = List<String>.from(value as List<dynamic>);
              });
            },
            items: _categories2.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            isExpanded: true,
            // Enable multiple selection
            isDense: true,
            iconSize: 30,
            elevation: 16,
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.blue,
            dropdownColor: Colors.white,
          ),
        ),

        // Display selected categories
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Selected Categories 1: ${_selectedCategories1.isEmpty ? "None" : _selectedCategories1.join(", ")}\n'
            'Selected Categories 2: ${_selectedCategories2.isEmpty ? "None" : _selectedCategories2.join(", ")}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Button to add random items
        ElevatedButton(
          onPressed: () {
            setState(() {
              _randomItems.add(generateRandomItems());
            });
          },
          child: Text('Add Random Items'),
        ),

        // List to display random items
        Expanded(
          child: ListView.builder(
            itemCount: _randomItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_randomItems[index][0]), // category
                subtitle: Text('Date: ${_randomItems[index][1]}, Price: ${_randomItems[index][2]}'),
              );
            },
          ),
        ),
      ],
    );
  }

  List<String> generateRandomItems() {
    Random random = Random();
    List<String> items = [];
    int categoryIndex = random.nextInt(_categories1.length);
    items.add(_categories1[categoryIndex]); // category
    items.add(DateTime.now().toString()); // date (current date)
    items.add('\$${random.nextInt(100)}'); // price (random number between 0 and 99)
    return items;
  }
}
class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              // Use the user's profile picture here
             backgroundImage: AssetImage('assets/National-Flower-Day.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'User Name', // Display the user's name here
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'user@example.com', // Display the user's email here
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Edit Profile'),
              leading: Icon(Icons.edit),
              onTap: () {
                // Navigate to the edit profile screen
              },
            ),
            Divider(),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock),
              onTap: () {
                // Navigate to the change password screen
              },
            ),
            Divider(),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                // Implement logout functionality
              },
            ),
            Divider(),
            // You can add more options as needed
          ],
        ),
      ),
    );
  }
}