import 'package:crypto_tracker_app/widgets/coffee_appbar.dart';
import 'package:flutter/material.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: coffeeAppbar(), backgroundColor: Colors.white);
  }
}
