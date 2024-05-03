import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MinhaSegundaTela extends StatefulWidget {
  const MinhaSegundaTela({super.key});

  @override
  State<MinhaSegundaTela> createState() => _MinhaSegundaTelaState();
}

class _MinhaSegundaTelaState extends State<MinhaSegundaTela> {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> _users = [];

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost:5000/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _users = data.map((userJson) => User.fromJson(userJson)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteUser(user.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add user page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserPage()),
          ).then((value) {
            if (value == true) {
              _fetchUsers(); // Refresh user list after adding new user
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('http://localhost:5000/users/$userId'));
    if (response.statusCode == 200) {
      _fetchUsers(); // Refresh user list after deleting user
    } else {
      throw Exception('Failed to delete user');
    }
  }
}

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _addUser() async {
    final String name = _nameController.text;
    final String email = _emailController.text;

    final response = await http.post(
      Uri.parse('http://localhost:5000/users'),
      body: jsonEncode({'name': name, 'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      Navigator.pop(context, true); // Navigate back to previous page with result
    } else {
      throw Exception('Failed to add user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}