import 'package:api_calls/bloc/Authbloc/auth_bloc.dart';
import 'package:api_calls/config/snakbars.dart';
import 'package:api_calls/screens/home.dart';
import 'package:api_calls/utils/emuns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocProvider(
        create: (context) => _authBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(hintText: "username"),
                ),
                const SizedBox(height: 26),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(height: 18),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.authStatus == AuthStatus.success) {
                      Snakbars.greenSnackBar(context, "Logged in success");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    }
                    if (state.authStatus == AuthStatus.failed) {
                      Snakbars.redSnackBar(
                          context, "Logging in Failed ${state.msg}");
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_email.text.isEmpty || _password.text.isEmpty) {
                            Snakbars.redSnackBar(
                                context, "Please fill the fields");
                          } else {
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: _email.text.toString(),
                                    password: _password.text.toString(),
                                  ),
                                );
                          }
                        },
                        child: const Text("Login"),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
