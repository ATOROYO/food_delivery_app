import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteNames {
  static const String login = '/login';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String orders = '/orders';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialization
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBgBwMf5BBz3BIyn2aMb0eNoQ5dUFZS8P4",
        appId: "1:608358143569:android:47c613c656cee300860a70",
        messagingSenderId: "608358143569",
        projectId: "food-delivery-app-474a1",
      ),
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  // Test Firestore connection
  testFirestoreConnection();

  // Global error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Global error: ${details.exceptionAsString()}');
  };

  runApp(const MyApp());
}

void testFirestoreConnection() async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('food_items').get();
    if (snapshot.docs.isNotEmpty) {
      debugPrint(
          'Firestore connection successful. Data found: ${snapshot.docs.length}');
    } else {
      debugPrint('Firestore connected but no data found.');
    }
  } catch (e) {
    debugPrint('Error connecting to Firestore: $e');
  }
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
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              fontFamily: 'Roboto',
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.blueAccent,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.black,
              fontFamily: 'Roboto',
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.blueGrey,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            initialRoute: RouteNames.login,
            routes: {
              RouteNames.login: (context) => LoginScreen(),
              RouteNames.home: (context) => HomeScreen(),
              RouteNames.cart: (context) => CartScreen(),
              RouteNames.orders: (context) => OrderHistoryScreen(),
            },
          );
        },
      ),
    );
  }
}
