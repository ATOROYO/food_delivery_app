import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Disable debug banner
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.black,
            ),
            initialRoute: '/login', // Initial route
            routes: {
              '/login': (context) => LoginScreen(),
              '/home': (context) => HomeScreen(),
              '/cart': (context) => CartScreen(),
              '/orders': (context) => OrderHistoryScreen(),
            },
          );
        },
      ),
    );
  }
}
