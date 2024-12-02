import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Delivery App'),
      ),
      bottomNavigationBar: NavigationBar(),
      body: Center(
        child: Text('Food Items List Coming Soon'),
      ),
    );
  }
}
