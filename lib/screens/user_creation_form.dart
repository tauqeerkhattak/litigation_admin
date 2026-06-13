import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';
import 'package:litigation_admin/utils/validators.dart';

import '../controllers/user_controller.dart';
import '../utils/constants.dart';
import '../utils/string_utils.dart';

class UserCreationForm extends StatefulWidget {
  const UserCreationForm();

  @override
  State<UserCreationForm> createState() => _UserCreationFormState();
}

class _UserCreationFormState extends State<UserCreationForm> {
  final _userRoleNotifier = ValueNotifier<UserRole?>(null);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return AlertDialog(
      constraints: BoxConstraints(minWidth: MediaQuery.widthOf(context) * 0.4),
      title: const Text('Add New User'),
      content: StateSelector<UserController, bool>(
        selector: (c) => c.state.isLoading,
        builder: (context, loading) {
          if (loading) {
            return SizedBox(
              height: MediaQuery.widthOf(context) * 0.4,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: Validators.notEmpty,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: Validators.notEmpty,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefix: Text('+92'),
                    ),
                    validator: Validators.notEmpty,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<UserRole>(
                    validator: (role) {
                      if (role == null) {
                        return 'Role is required!';
                      }
                      return null;
                    },
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
          );
        },
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            final userController = ControlRoom.get<UserController>(context);
            Navigator.pop(context);
            final phone = phoneController.text.trim();
            final updatedPhone = phone.startsWith('0')
                ? phone.substring(1)
                : phone;
            await userController.createUser({
              'email': emailController.text.trim(),
              'password': passwordController.text,
              'name': nameController.text.trim(),
              'role': _userRoleNotifier.value!.name,
              'country_code': '+92',
              'phone_number': updatedPhone,
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
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
