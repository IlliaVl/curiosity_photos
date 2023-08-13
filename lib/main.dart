import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/network/nasa_client.dart';
import 'data/providers/firebase_auth_provider.dart';
import 'data/providers/nasa_photos_provider.dart';
import 'data/repositories/firebase_auth_repository.dart';
import 'domain/cubits/auth_cubit.dart';
import 'env.dart';
import 'firebase_options.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/main_screen.dart';

Future<void> main() async {
  final netClient = NasaClient();
  NASAPhotosProvider(
    netClient,
  ).getPhotos(Env.nasaApiKey).then(
        (value) => print(value),
      );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
          : const MyHomePage(
              title: 'Flutter Demo Home Page',
            ),
    );
  }
}
