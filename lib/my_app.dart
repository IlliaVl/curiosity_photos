import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/network/nasa_client.dart';
import 'data/providers/firebase_auth_provider.dart';
import 'data/providers/nasa_photos_provider.dart';
import 'data/repositories/firebase_auth_repository.dart';
import 'data/repositories/nasa_repository.dart';
import 'domain/cubits/auth/auth_cubit.dart';
import 'domain/cubits/photos/mars_photos_cubit.dart';
import 'env.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(
                repository: FirebaseAuthRepository(
                  provider: FirebaseAuthProvider(),
                ),
              ),
              child: const LoginScreen(),
            )
          : BlocProvider<MarsPhotosCubit>(
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
    );
  }
}
