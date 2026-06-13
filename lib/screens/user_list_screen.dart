import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/constants.dart';
import '../utils/string_utils.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _searchQuery = '';
  final _userRoleNotifier = ValueNotifier<UserRole?>(null);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ControlRoom.get<UserController>(context).fetchUsers();
    });
  }

  void _addNewUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
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
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<UserRole>(
                  items: UserRole.values
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(role.name.capitalize),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _userRoleNotifier.value = value;
                  },
                  decoration: const InputDecoration(labelText: 'Role'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  final userController = ControlRoom.get<UserController>(
                    context,
                  );
                  Navigator.pop(context);

                  await userController.createUser({
                    'email': emailController.text.trim(),
                    'password': passwordController.text,
                    'name': nameController.text.trim(),
                    'role': _userRoleNotifier.value,
                    'country_code': '+92',
                    'phone_number': phoneController.text.trim(),
                  });

                  if (context.mounted) {
                    if (userController.state.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(userController.state.error!),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User created successfully'),
                          backgroundColor: AppColors.green,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _sendPasswordResetLink(String uid) async {
    final success = await ControlRoom.get<AuthController>(
      context,
    ).forgotPassword(uid);
    if (success ?? false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent'),
            backgroundColor: AppColors.navy,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _userRoleNotifier.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateListener<UserController, UserState>(
      builder: (context, state) {
        final filteredUsers = state.users.where((user) {
          return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Manage Users')),
          body: Column(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: state.isLoading && state.users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : filteredUsers.isEmpty
                    ? const Center(child: Text('No users found.'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: filteredUsers.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetailScreen(user: user),
                                ),
                              );
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
                                      icon: const Icon(Icons.vpn_key_outlined),
                                      onPressed: () =>
                                          _sendPasswordResetLink(user.uid),
                                      tooltip: 'Send Password Reset',
                                      color: AppColors.muted,
                                    ),
                                    Switch(
                                      value: !user.disabled,
                                      onChanged: (value) =>
                                          ControlRoom.get<UserController>(
                                            context,
                                          ).disableUser(user.uid),
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
      },
    );
  }
}
