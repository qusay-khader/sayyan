import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayyan/screens/check_email_screen.dart';
import 'package:sayyan/screens/admin_dashboard.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Connected Successfully");
  } catch (e) {
    print("❌ Firebase Connection Error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sayyan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/check-email': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return CheckEmailScreen(email: email);
        },
        '/set-new-password': (context) => const SetNewPasswordScreen(),
        '/password-reset-success': (context) => const PasswordResetScreen(),
        '/home': (context) => const HomeScreen(),
        '/service-request': (context) => const ServiceRequestScreen(),
        '/profile': (context) => const ProfileScreenEnhanced(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/subscriptions': (context) => const SubscriptionsScreen(),
        '/requests': (context) => const RequestsScreen(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/craftsman-home': (context) => const CraftsmanRegistrationScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          final userEmail = snapshot.data!.email ?? '';

          // Hardcoded admin check (no Firestore)
          if (userEmail == 'admin@sayyan.com') {
            print('✅ Admin logged in');
            return AdminDashboard();
          }
          // For other users, go to HomeScreen
          else {
            print('✅ Normal user logged in');
            return const HomeScreen();
          }
        }

        return const LoginScreen();
      },
    );
  }
}
