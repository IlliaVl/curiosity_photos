import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/nasa_client.dart';
import '../../data/providers/nasa_photos_provider.dart';
import '../../data/repositories/nasa_repository.dart';
import '../../domain/cubits/auth/auth_cubit.dart';
import '../../domain/cubits/photos/mars_photos_cubit.dart';
import '../../env.dart';
import '../mixins/errors_snack_bar_mixin.dart';
import 'main_screen.dart';

/// Screen is responsible for login.
class LoginScreen extends StatelessWidget with ErrorsSnackBarMixin {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BlocProvider<MarsPhotosCubit>(
                create: (context) => MarsPhotosCubit(
                  repository: NasaRepository(
                    provider: NasaPhotosProvider(
                      netClient: NasaClient(),
                      apiKey: Env.nasaApiKey,
                    ),
                  ),
                )..load(),
                child: const MainScreen(),
              ),
            ),
          );
        } else if (state is AuthErrorGeneric) {
          showGenericErrorSnackBar(context);
        } else if (state is AuthErrorNetwork) {
          showNetworkErrorSnackBar(context);
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
      ),
    );
  }
}
