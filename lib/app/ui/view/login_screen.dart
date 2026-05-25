import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/app/routes.dart';
import 'package:music_player/app/ui/viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  final AuthViewmodel authViewmodel;

  const LoginScreen({
    super.key,
    required this.authViewmodel,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool isRegistering = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      final vm = widget.authViewmodel;
      final success = isRegistering
          ? await vm.register(username.text, password.text)
          : await vm.login(username.text, password.text);

      if (success) {
        context.go(Routes.musics);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.authViewmodel;

    return Scaffold(
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Music Player',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 48),

                  // username field
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // password field
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),

                  // error message
                  if (vm.errorMessage != null)
                    Text(
                      vm.errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 16),

                  // submit button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: vm.isLoading ? null : submit,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: vm.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                isRegistering ? 'Register' : 'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // toggle login/register
                  TextButton(
                    onPressed: () => setState(() => isRegistering = !isRegistering),
                    child: Text(
                      isRegistering
                          ? 'Already have an account? Login'
                          : 'No account? Register',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}