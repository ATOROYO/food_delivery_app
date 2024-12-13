# Flutter E-Commerce App

## Overview

This is a **Flutter-based E-Commerce App** designed to provide a seamless online shopping experience. It includes essential features like user authentication, a shopping cart, order history, and more. The app is built using **Firebase** for backend services and **Provider** for state management.

## Features

- **User Authentication:** Secure login and logout functionality with Firebase Authentication.
- **Shopping Cart:** Add items to the cart, view the cart, and calculate total costs.
- **Order Placement:** Place orders and store them in Firestore for future reference.
- **Order History:** View a list of previous orders.
- **Theme Support:** Toggle between light and dark themes.

## Installation

### Prerequisites

- Flutter SDK installed ([Flutter Installation Guide](https://docs.flutter.dev/get-started/install)).
- Firebase project set up with Firestore and Authentication ([Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)).
- Code editor (e.g., Visual Studio Code or Android Studio).

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/ATOROYO/food_delivery_app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd food_delivery_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Set up Firebase:

   - Add `google-services.json` (for Android) to the `android/app` directory.
   - Add `GoogleService-Info.plist` (for iOS) to the `ios/Runner` directory.

5. Run the app:
   ```bash
   flutter run
   ```

## File Structure

```plaintext
lib/
|
|-- main.dart              # Entry point of the app
|-- providers/             # State management files
|   |-- theme_provider.dart
|   |-- cart_provider.dart
|
|-- screens/               # UI screens
|   |-- admin_panel.dart
|   |-- login_screen.dart
|   |-- home_screen.dart
|   |-- cart_screen.dart
|   |-- order_history_screen.dart
|
|-- widgets/               # Reusable widgets (if any)
|   |-- food_item_card.dart
|   |-- navigation_bar.dart
|
|-- models/                # Data models (e.g., cart items)
|   |-- food_item.dart
|   |-- order.dart
```

## Key Files

### 1. `main.dart`

- Initializes Firebase.
- Sets up `MultiProvider` for state management.
- Determines the home screen based on user authentication state.

### 2. `login_screen.dart`

- Handles user login.
- Uses `FirebaseAuth` for authentication.

### 3. `home_screen.dart`

- Displays available items.
- Allows users to browse through products.

### 4. `cart_screen.dart`

- Displays items added to the cart.
- Provides functionality to place orders.

### 5. `order_history_screen.dart`

- Shows a list of past orders fetched from Firestore.

## Dependencies

This project uses the following dependencies:

- **firebase_core:** Firebase integration.
- **firebase_auth:** User authentication.
- **cloud_firestore:** Firestore database for storing user data.
- **provider:** State management solution.

Add these dependencies in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest_version
  firebase_auth: ^latest_version
  cloud_firestore: ^latest_version
  provider: ^latest_version
```

## Usage

1. **Log in:** Start the app and log in with your Firebase credentials.
2. **Browse Products:** Navigate through available products on the `HomeScreen`.
3. **Add to Cart:** Add products to your cart.
4. **Place Orders:** View your cart and place an order.
5. **Order History:** Check past orders from the `OrderHistoryScreen`.

## Screenshots

Below are some of the screen shorts of the app

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push the branch:
   ```bash
   git push origin feature-name
   ```
4. Open a pull request.

---

### Contact

For any questions or issues, feel free to contact:

- **Author:** David Atoroyo Sika
- **Email:** [davidatoroyosika@gmail.com]
