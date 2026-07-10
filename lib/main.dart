import 'package:crypto_tracker_app/blocs/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/crypto_event.dart';
import 'cubits/favorites_cubit.dart';
import 'screens/crypto_tracker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Tracker',

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1f1f1f),
          elevation: 0,
        ),
      ),

      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CryptoBloc()..add(FetchCryptoPrices()),
          ),
          BlocProvider(create: (context) => FavoritesCubit()),
        ],
        child: const CryptoTrackerScreen(),
      ),
    );
  }
}
