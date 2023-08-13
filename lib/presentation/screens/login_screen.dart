import 'package:curiosity_photos/domain/cubits/auth_cubit.dart';
import 'package:curiosity_photos/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen is responsible for login.
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(
                title: 'Flutter Demo Home Page',
              ),
            ),
          );
        } else if (state is AuthErrorGeneric) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Try later, please.'),
            ),
          );
        } else if (state is AuthErrorNetwork) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sorry, there was a network error. '
                  'Please check your internet connection and try again.'),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 36.0,
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Curiosity Photos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state is! AuthLoggingIn
                          ? context.read<AuthCubit>().anonymousAuth
                          : null,
                      child: state is! AuthLoggingIn
                          ? const Text('Sign In')
                          : const SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // body: Center(
        //   child: CircularProgressIndicator(),
        // ),
      ),
    );
  }
}
