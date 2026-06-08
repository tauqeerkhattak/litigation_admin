import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // Mock data for UI-only version
  final List<UserModel> _allUsers = [
    UserModel(id: '1', name: 'John Doe', email: 'john@example.com'),
    UserModel(id: '2', name: 'Jane Smith', email: 'jane@example.com'),
    UserModel(id: '3', name: 'Advocate Malik', email: 'malik@court.com'),
  ];

  List<UserModel> _filteredUsers = [];
  String _searchQuery = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filterUsers();
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _toggleUserStatus(int index) {
    setState(() {
      final user = _filteredUsers[index];
      user.isEnabled = !user.isEnabled;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'User ${_filteredUsers[index].isEnabled ? 'enabled' : 'disabled'} successfully',
        ),
        backgroundColor: _filteredUsers[index].isEnabled
            ? AppColors.green
            : AppColors.red,
      ),
    );
  }

  void _sendForgotPassword(UserModel user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Forgot password email sent to ${user.email}'),
        backgroundColor: AppColors.navy,
      ),
    );
  }

  void _addNewUser() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final emailController = TextEditingController();
        return AlertDialog(
          title: const Text('Add New User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty) {
                  setState(() {
                    _allUsers.add(
                      UserModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text,
                        email: emailController.text,
                      ),
                    );
                    _filterUsers();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Users')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search users...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    onChanged: (value) {
                      _searchQuery = value;
                      _filterUsers();
                    },
                  ),
                ),
                Expanded(
                  child: _filteredUsers.isEmpty
                      ? const Center(child: Text('No users found.'))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: _filteredUsers.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserDetailScreen(user: user),
                                  ),
                                ).then((_) => setState(() {}));
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.creamDark,
                                    child: Text(
                                      user.name.isNotEmpty ? user.name[0] : '?',
                                      style: const TextStyle(
                                        color: AppColors.navy,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(user.email),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.vpn_key_outlined,
                                        ),
                                        onPressed: () =>
                                            _sendForgotPassword(user),
                                        tooltip: 'Send Password Reset',
                                        color: AppColors.muted,
                                      ),
                                      Switch(
                                        value: user.isEnabled,
                                        onChanged: (value) =>
                                            _toggleUserStatus(index),
                                        activeThumbColor: AppColors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewUser,
        child: const Icon(Icons.person_add_rounded),
      ),
    );
  }
}
